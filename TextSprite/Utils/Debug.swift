//
//  Debug.swift
//  BeWords
//
//  Created by apple on 2024/9/13.
//

import Foundation

public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}
