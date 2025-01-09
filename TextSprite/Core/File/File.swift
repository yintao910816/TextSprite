//
//  File.swift
//  TextSprite
//
//  Created by apple on 2025/1/9.
//

import Foundation

public struct SystemFile {
    /// 完整文件名
    let fileName: String
    /// 文件名（不带扩展名）
    let fileNameWithoutExtension: String
    /// 文件扩展名
    let fileExtension: String
    /// 文件路径
    let path: String

    init(_ url: URL) {
        self.fileName = url.lastPathComponent
        self.fileNameWithoutExtension = url.deletingPathExtension().lastPathComponent
        self.fileExtension = url.pathExtension
        self.path = url.path
    }
}
