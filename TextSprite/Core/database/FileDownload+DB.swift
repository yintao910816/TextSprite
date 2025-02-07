//
//  FileDownload+DB.swift
//  TextSprite
//
//  Created by apple on 2025/1/23.
//

import SQLite
import SwiftSignalKitTG

private let idKey = Expression<Int64>("id")
private let dataKey = Expression<Data>("data")

extension FileDownload: Codable {
   
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)
        self.fileName = try container.decode(String.self, forKey: "fn")
        self.timestamp = try container.decode(Int32.self, forKey: "tt")
        self.id = try container.decode(Int32.self, forKey: "id")
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)
        try container.encode(self.fileName, forKey: "fn")
        try container.encode(self.timestamp, forKey: "tt")
        try container.encode(self.id, forKey: "id")
    }
}

extension FileDownload: DBOperation {
    
    static public var table: Table {
        return Table(TableName.fileDownload.rawValue)
    }
    
    static public func createTable() {
        do {
            try ClientDatabaseInstance.runDatabase(ClientDatabaseInstance.createTable(self.table, ifNotExists: true){ t in
                t.column(idKey, primaryKey: true)
                t.column(dataKey)
            })
        } catch {
            print("createTable \(self.table) error：\(error)")
        }
    }

    public static func add(dbModel: any DBOperation) {
        guard let fileDB = dbModel as? FileDownload else { return }
        let data = InnerEncodable(fileDB)
        do {
            try ClientDatabaseInstance.runDatabase(ClientDatabaseInstance.insertTable(or: self.table, .replace,
                                                                                      idKey <- Int64(fileDB.id),
                                                                                      dataKey <- data
                                                                                     ))
        } catch {
            print("add \(self.table) error：\(error)")
        }
    }
    
    public static func selectAll() -> Signal<[any DBOperation], NoError> {
        return Signal { subscriber in
            let filter = ClientDatabaseInstance.filterTable(self.table, idKey != 0)
            do {
                var results: [FileDownload] = []
                let rows = Array(try ClientDatabaseInstance.prepareDatabase(filter))
                for row in rows {
                    if let data = try? row.get(dataKey), let dataModel = InnerDecodable(FileDownload.self, data: data) {
                        results.append(dataModel)
                    }
                }
                subscriber.putNext(results)
                subscriber.putCompletion()
            } catch {
                print("selected \(self.table) error：\(error)")
                subscriber.putNext([])
                subscriber.putCompletion()
            }

            return EmptyDisposable
        }
    }
}
