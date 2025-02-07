//
//  HomeController.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import UniformTypeIdentifiers

import TGSubmodoules
import SwiftSignalKitTG

struct HomeControllerInteraction {
    let testAction: ()->()
    
    init(testAction: @escaping () -> Void) {
        self.testAction = testAction
    }
}

public class HomeController: BaseController {
    private var interaction: HomeControllerInteraction?
    
    private var controllerNode: HomeControllerNode {
        return self.displayNode as! HomeControllerNode
    }

    public override init(context: any AccountContext, navigationBarParameters: NavigationBarParameters?) {
        super.init(context: context, navigationBarParameters: navigationBarParameters)
        
        self.interaction = HomeControllerInteraction(testAction: { [weak self] in
            self?.openSystemFile()
        })
        
        _ = FileDownload.selectAll()
            .start(next: { rs in
                if let first = rs.first as? FileDownload {
                    readAndSplitTextFile(fileURL: first.destinationURL)
                }
            })
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadDisplayNode() {
        self.displayNode = HomeControllerNode(context: self.context, presentationData: self.presentationData, interaction: self.interaction!)
        self.displayNode.view.backgroundColor = .white
        self.displayNodeDidLoad()
    }
    
    public override func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
        self.controllerNode.containerLayoutUpdated(layout, navigationHeight: 0, transition: transition)
    }
}

extension HomeController: UIDocumentPickerDelegate {
    
    private func openSystemFile() {
        // 创建文件选择器，只允许选择 .txt 文件
        let documentPicker: UIDocumentPickerViewController
        if #available(iOS 14.0, *) {
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.plainText])
        } else {
            documentPicker = UIDocumentPickerViewController(documentTypes: ["public.plain-text"], in: .import)
        }
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    // MARK: - UIDocumentPickerDelegate
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        if selectedFileURL.startAccessingSecurityScopedResource() {
            defer { selectedFileURL.stopAccessingSecurityScopedResource() }
            do {
                let file = SystemFile(selectedFileURL)
                debugPrint("读取文件：\(file)")
                file.matchesChapter()

//                let fileContents = try String(contentsOf: selectedFileURL, encoding: .utf8)
//                print("文件内容:\n\(fileContents)")
            } catch {
                print("读取文件失败: \(error)")
            }
        } else {
            print("无法访问选定的文件资源")
        }
        
        guard let selectedFileURL = urls.first else { return }
    }

    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("用户取消了文件选择")
    }

}
