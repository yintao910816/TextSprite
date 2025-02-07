//
//  DBServer.swift
//  BeWords
//
//  Created by apple on 2024/6/12.
//

import Foundation
import SQLite

public let ClientDatabaseInstance = ClientDatabase.shared
public typealias TableName = ClientDatabase.TableName

public class ClientDatabase {
    
    public enum TableName: String {
        case fileDownload = "file_download_v01"
    }
    
    static var shared = ClientDatabase()

    private let databaseSemap = DispatchSemaphore(value: 0)
    private let docuPath: String
    private let dbPath: String

    private var database: Connection!

    init() {
        self.databaseSemap.signal()

        self.docuPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true).first!
        self.dbPath = self.docuPath + "/client_data.db"
        print("===dbPath==\(self.dbPath)")
    }
 
    public func connectionDataBase() {
        do {
            let database = try Connection.init(self.dbPath, readonly: false)
            
            // 暂时不使用，外键支持需要 SQLite 3.6.19以上版本
//            try database.run("PRAGMA foreign_keys = ON")

            database.busyTimeout = 5
            database.busyHandler { (tries) -> Bool in
                if tries >= 3 {
                    return false
                }
                return true
            }
            self.database = database
            
//            if let sqliteVersion = try database.scalar("SELECT sqlite_version()") as? String {
//                print("SQLite version: \(sqliteVersion)")
//            }
//            if let foreignKeysEnabled = try self.database.scalar("PRAGMA foreign_keys") as? Int, foreignKeysEnabled == 1 {
//                print("Foreign keys are enabled")
//            } else {
//                print("Foreign keys are not enabled")
//            }

        } catch {
            print("tgdbdata connection error==\(error)")
        }
    }
    
    public func setupTables() {
        FileDownload.createTable()
    }
    
    public func removeAllTables(onlyDb: Bool) {

    }

    private func lock() -> Void {
        self.databaseSemap.wait()
    }

    private func unLock() -> Void {
        self.databaseSemap.signal()
    }
}

extension ClientDatabase {
    
    @discardableResult 
    public func scalarDatabase<V : Value>(_ query: ScalarQuery<V?>) throws -> V.ValueType? {
        lock()
        var v: V.ValueType?
        do {
            v = try database.scalar(query)
            unLock()
            return v
        } catch  {
            unLock()
            throw error
        }
    }
    @discardableResult
    public func scalarDatabase<V : Value>(_ query: ScalarQuery<V>) throws -> V {
        lock()
        var v: V
        do {
            v = try database.scalar(query)
            unLock()
            return v
        } catch  {
            unLock()
            throw error
        }
    }
    
    @discardableResult 
    public func runDatabase(_ statement: String, _ bindings: Binding?...) throws -> Statement {
        lock()
        var s: Statement
        do {
            s = try database.run(statement, bindings)
            unLock()
            return s
        } catch {
            unLock()
            throw error
        }
    }
    @discardableResult 
    public func runDatabase(_ query: Delete) throws -> Int {
        lock()
        var s: Int
        do {
            s = try database.run(query)
            unLock()
            return s
        } catch  {
            unLock()
            throw error
        }
    }
    @discardableResult 
    public func runDatabase(_ query: Insert) throws -> Int64 {
        lock()
        var s: Int64
        do {
            s = try database.run(query)
            unLock()
            return s
        } catch  {
            unLock()
            throw error
        }
    }
    @discardableResult 
    public func runDatabase(_ query: Update) throws -> Int {
        lock()
        var s: Int
        do {
            s = try database.run(query)
            unLock()
            return s
        } catch  {
            unLock()
            throw error
        }
    }
    @discardableResult 
    public func prepareDatabase(_ query: QueryType) throws -> AnySequence<Row> {
        lock()
        var a: AnySequence<Row>
        do {
            a = try database.prepare(query)
            unLock()
            return a
        } catch {
            unLock()
            throw error
        }
    }
    
}

extension ClientDatabase {
    
    @discardableResult 
    public func createTable(_ table:Table, temporary: Bool = false, ifNotExists: Bool = false, withoutRowid: Bool = false, block: (TableBuilder) -> Void) -> String {
        var string: String
        lock()
        string = table.create(temporary: temporary, ifNotExists: ifNotExists, withoutRowid: withoutRowid, block: block)
        unLock()
        return string
    }
    @discardableResult 
    public func selectTable<V>(_ table:Table, _ column: SQLite.Expression<V?>) -> SQLite.ScalarQuery<V?> where V : Value {
        var s: ScalarQuery<V?>
        lock()
        s = table.select(column)
        unLock()
        return s
    }
    @discardableResult 
    public func selectTable(_ table:Table, _ column1: Expressible, _ more: Expressible...) -> Table {
        var t: Table
        lock()
        t = table.select([column1] + more)
        unLock()
        return t
    }

    @discardableResult 
    public func updateTableColumn<V: Value>(table:Table, name: Expression<V>, check: Expression<Bool>? = nil, defaultValue: V) -> String {
        var t: String
        lock()
        t = table.addColumn(name, check: check, defaultValue: defaultValue)
        unLock()
        return t
    }

    @discardableResult 
    public func filterTable(_ table:Table, _ predicate: SQLite.Expression<Bool>) -> Table {
        var t: Table
        lock()
        t = table.filter(predicate)
        unLock()
        return t
    }
    @discardableResult 
    public func insertTable(or table:Table, _ onConflict: SQLite.OnConflict, _ values: SQLite.Setter...) -> SQLite.Insert {
        var i: SQLite.Insert
        lock()
        i = table.insert(or: onConflict, values)
        unLock()
        return i
    }
    @discardableResult
    public func updateTable(_ table:Table, _ values: SQLite.Setter...) -> SQLite.Update {
        var i: SQLite.Update
        lock()
        i = table.update(values)
        unLock()
        return i
    }
    @discardableResult
    public func deleteTable(_ table:Table) -> Delete {
        var i: Delete
        lock()
        i = table.delete()
        unLock()
        return i
    }

    @discardableResult 
    public func orderTable(_ table:Table, _ by: Expressible...) -> Table {
        var i: Table
        lock()
        i = table.order(by)
        unLock()
        return i
    }

    @discardableResult 
    public func limitTable(_ table:Table, _ length: Int, offset: Int) -> Table {
        var i: Table
        lock()
        i = table.limit(length, offset: offset)
        unLock()
        return i
    }
    @discardableResult
    public func whereTable(_ table:Table, _ predicate: Expression<Bool>) -> Table {
        var i: Table
        lock()
        i = table.where(predicate)
        return i
    }
}
