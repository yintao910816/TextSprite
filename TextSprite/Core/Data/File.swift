//
//  File.swift
//  TextSprite
//
//  Created by apple on 2025/1/9.
//

import Foundation
import SwiftSignalKitTG

public struct SystemFile {
    /// 完整文件名
    let fileName: String
    /// 文件名（不带扩展名）
    let fileNameWithoutExtension: String
    /// 文件扩展名
    let fileExtension: String
    /// 文件路径
    let path: String
    /// 原始URL
    let url: URL

    private let queue = DispatchQueue(label: "chapter")
    
    init(_ url: URL) {
        self.url = url
        self.fileName = url.lastPathComponent
        self.fileNameWithoutExtension = url.deletingPathExtension().lastPathComponent
        self.fileExtension = url.pathExtension
        self.path = url.path
    }
    
    public func matchesChapter() {
        self.queue.async {
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsPath.appendingPathComponent("《貌美向导深陷修罗场》作者：长日楠.txt")
//            readAndSplitTextFile(fileURL: self.url)
            readAndSplitTextFile(fileURL: destinationURL)
        }
    }
}

public struct FictionBook {
    struct Chapter {
        let title: String
        let content: String
    }
    
    let title: String
    let chapters: [Chapter]
}

public func readAndSplitTextFile(fileURL: URL) {
    do {
        let content = ReadTextParser.parser(book: fileURL)
        print(content)

//        if fileURL.startAccessingSecurityScopedResource() {
//            defer { fileURL.stopAccessingSecurityScopedResource() }
////            fullRead(fileURL: fileURL)
//            let content = ReadTextParser.parser(book: fileURL)
//            print(content)
////            if let fileContents = detectFileEncoding(fileURL: fileURL) {
//////                let text = """
//////                序章
//////                第一章
//////                Chapter 1
//////                Chapter 2
//////                第5章
//////                """
//////                fileContents = text
////                // 定义章节标题的正则表达式
//////                let pattern = "^(序章|第[零一二三四五六七八九十百千万]+章|Chapter \\d+)"
//////                let pattern = "^第[一二三四五六七八九十]+章$"
//////                let pattern = "(序章|第\\d+章)"
////                let pattern = "(序章|第\\d+章)"
////                let chapterRegex = try NSRegularExpression(pattern: pattern, options: [])
////                let matches = chapterRegex.matches(in: fileContents, options: [], range: NSRange(location: 0, length: fileContents.count))
////
////                // 查找所有章节标题的范围
//////                let matches = chapterRegex.matches(in: fileContents, options: [], range: NSRange(location: 0, length: fileContents.utf16.count))
////
////                var chapters = [String]()
////                var lastRangeEnd = 0
////                
////                for match in matches {
////                    let chapterRange = match.range
////                    let chapterTitle = (fileContents as NSString).substring(with: chapterRange)
////                    
////                    // 将上一章节内容与标题存储为一个章节
////                    if lastRangeEnd < chapterRange.location {
////                        let chapterText = (fileContents as NSString).substring(with: NSRange(location: lastRangeEnd, length: chapterRange.location - lastRangeEnd))
////                        chapters.append(chapterText)
////                    }
////                    
////                    // 存储章节标题
////                    print("找到章节: \(chapterTitle)")
////                    lastRangeEnd = chapterRange.location
////                }
////                
////                // 最后一章节
////                if lastRangeEnd < fileContents.count {
////                    let remainingChapterText = (fileContents as NSString).substring(from: lastRangeEnd)
////                    chapters.append(remainingChapterText)
////                }
////                
////                // 打印每个章节内容
////                for (index, chapter) in chapters.enumerated() {
////                    print("章节 \(index + 1): \(chapter.prefix(100))...") // 打印章节的前 100 个字符
////                }
////            }
//        }
    } catch {
        print("读取文件时出错: \(error)")
    }
}

private func detectFileEncoding(fileURL: URL) ->String? {
    let encodings: [String.Encoding] = [
        .utf8,
        .isoLatin1,
        .utf16,
        .ascii
    ]
    
    for encoding in encodings {
        print("文件编码格式：\(encoding)")
        do {
            let fileContents = try String(contentsOf: fileURL, encoding: encoding)
            return fileContents
        } catch {
            continue
        }
    }
    return nil
}

private func fullRead(fileURL: URL) {
    print("缓存文件地址:", Sand.readDocumentDirectoryPath)
    
//    guard let url = Bundle.main.url(forResource: "三国演义", withExtension: "txt") else { return }
    
    print("全本解析开始时间:",TimerString("YYYY-MM-dd-HH-mm-ss"), Date().timeIntervalSince1970)
    
    ReadTextParser.resolve(url: fileURL) { (readModel) in
        
        print("全本解析结束时间:",TimerString("YYYY-MM-dd-HH-mm-ss"), Date().timeIntervalSince1970)
    }
}

import TGSubmodoules
//MARK: 下载的原始文件
public struct FileDownload {
    let fileName: String
    /// 下载时间 - 秒级
    let timestamp: Int32
    let id: Int32
    
    public init(fileName: String) {
        self.fileName = fileName
        self.timestamp = Int32(Date().timeIntervalSince1970)
        self.id = murMurHashString32(fileName)
    }
    
    public var destinationURL: URL {
        let destinationURL = documentsPath.appendingPathComponent(self.fileName)
        return destinationURL
    }
    
    public static func downloadFile(from url: URL) {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) { location, response, error in
            guard let location = location, error == nil else {
                print("下载失败: \(error?.localizedDescription ?? "未知错误")")
                return
            }
            
            // 获取文件名
            let fileName = response?.suggestedFilename ?? url.lastPathComponent
            // 保存文件到 Documents 目录
            let destinationURL = documentsPath.appendingPathComponent(fileName)
            
            do {
                // 移动文件到目标位置
                try FileManager.default.moveItem(at: location, to: destinationURL)
                print("文件下载完成，保存到: \(destinationURL.path)")
                FileDownload.add(dbModel: FileDownload(fileName: fileName))                
            } catch {
                print("保存文件失败: \(error.localizedDescription)")
            }
        }
        
        downloadTask.resume()
    }
}

private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
