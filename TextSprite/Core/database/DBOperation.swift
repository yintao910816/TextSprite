//
//  DBOperation.swift
//  TextSprite
//
//  Created by apple on 2025/1/23.
//

import SQLite
import SwiftSignalKitTG

public protocol DBOperation {
    static var table: Table { get }
    static func createTable()
    static func add(dbModel: DBOperation)
    static func selectAll() -> Signal<[DBOperation], NoError>
}
