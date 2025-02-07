
import UIKit

/// 解析完成
typealias ParserCompletion = (_  readModel: ReadModel) ->Void

class ReadParserIMP: NSObject {
    
    // MARK: -- 内容分页
    
    /// 内容分页
    ///
    /// - Parameters:
    ///   - attrString: 内容
    ///   - rect: 显示范围
    ///   - isFirstChapter: 是否为本文章第一个展示章节,如果是则加入书籍首页。(小技巧:如果不需要书籍首页,可不用传,默认就是不带书籍首页)
    /// - Returns: 内容分页列表
    class func pageing(attrString:NSAttributedString, rect:CGRect, isFirstChapter:Bool = false) ->[ReadPageModel] {
        
        var pageModels = [ReadPageModel]()
        
        if isFirstChapter { // 第一页为书籍页面
            
            let pageModel = ReadPageModel()
            
            pageModel.pageRange = NSMakeRange(TypeSetting.readBookHomePage, 1)
            
            pageModel.contentSize = READ_VIEW_RECT.size
            
            pageModels.append(pageModel)
        }
        let ranges = CoreText.pagingRanges(attrString: attrString, rect: rect)
        /*
        let rangesX = CoreText.pagingRanges(attrString: attrString, rect: rect)
        var ranges = [NSRange]()
        var i = 0
        let count = rangesX.count
        let final = rangesX[count - 1].location + rangesX[count - 1].length
        let extra = 1
        while i < count {
            switch i{
            case 0:
                ranges.append(NSRange(location: rangesX[i].location, length: rangesX[i].length + extra))
            default:
                let begin = ranges[i - 1].location + ranges[i - 1].length
                ranges.append(NSRange(location: begin, length: rangesX[i].length + extra))
            }
            i += 1
        }
        ranges = ranges.filter({ (range) -> Bool in
            range.location < final
        })
        ranges = ranges.map({ (range) -> NSRange in
            var r = range
            if range.location + range.length > final{
                r.length = final - range.location
            }
            return r
        })
        
        */
        if !ranges.isEmpty {
            
            let count = ranges.count
            
            for i in 0..<count {
                
                let range = ranges[i]
                
                let pageModel = ReadPageModel()
                
                let content = attrString.attributedSubstring(from: range)
                
                pageModel.pageRange = range
                
                pageModel.content = content
                
                pageModel.page = i
                
                // --- (滚动模式 || 长按菜单) 使用 ---
                
                // 注意: 为什么这些数据会放到这里赋值，而不是封装起来， 原因是 contentSize 计算封装在 pageModel内部计算出现宽高为0的情况，所以放出来到这里计算，原因还未找到，但是放到这里计算就没有问题。封装起来则会出现宽高度不计算的情况。
                
                // 内容Size (滚动模式 || 长按菜单)
                let maxW = READ_VIEW_RECT.width
                
                pageModel.contentSize = CGSize(width: maxW, height: CoreText.GetAttrStringHeight(attrString: content, maxW: maxW))
                
                
                // 当前页面开头是什么数据开头 (滚动模式)
                if i == 0 { pageModel.headType = .chapterName
                    
                }else if content.string.hasPrefix(TypeSetting.readSpace) { pageModel.headType = .paragraph
                    
                }else{ pageModel.headType = .line }
                
                
                // 根据开头类型返回开头高度 (滚动模式)
                switch pageModel.headType {
                case .chapterName:
                    pageModel.headTypeHeight = 0
                case .paragraph:
                    pageModel.headTypeHeight = ReadConfigure.shared.paragraphSpacing
                default:
                    pageModel.headTypeHeight = ReadConfigure.shared.lineSpacing
                }
               
                
                // --- (滚动模式 || 长按菜单) 使用 ---
                
                pageModels.append(pageModel)
            }
        }
        
        return pageModels
    }
    
    
    // MARK: -- 内容整理排版
    
    /// 内容排版整理
    ///
    /// - Parameter content: 内容
    /// - Returns: 整理好的内容
    class func contentTypesetting(content:String) ->String {
        
        // 替换单换行
        let content = content.replacingOccurrences(of: "\r", with: "")
        
        // 替换换行 以及 多个换行 为 换行加空格
        return content.replacingCharacters("\\s*\\n+\\s*", "\n" + TypeSetting.readSpace)
    }
    
    
    // MARK: -- 解码URL
    
    /// 解码URL
    ///
    /// - Parameter url: 文件路径
    /// - Returns: 内容
    class func encode(url:URL) -> String {
        
        var content = ""
        
        if url.absoluteString.isEmpty { return content }
        
        content = detectFileEncoding(fileURL: url)
                
        return content
    }
        
    private class func detectFileEncoding(fileURL: URL) ->String {
        let encodings: [String.Encoding] = [
            .utf8,
            .ascii,
            .utf16,
            .unicode,
            .isoLatin1
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
        return ""
    }

}
