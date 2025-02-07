//
//  WebControllerNode.swift
//  TextSprite
//
//  Created by apple on 2025/1/21.
//

import WebKit

import TGSubmodoules

class WebControllerNode: BaseDisplayNode {
    private let interaction: WebControllerInteraction
    
    private let webView: WKWebView
    private let toolBarNode: WebToolbarNode
    
    
    init(context: any AccountContext, presentationData: PresentationData, interaction: WebControllerInteraction) {
        self.interaction = interaction
        
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)

        self.toolBarNode = WebToolbarNode(context: context, presentationData: presentationData)
        
        super.init(context: context, presentationData: presentationData)
        
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        self.addSubnode(self.toolBarNode)
        
        self.toolBarNode.webGoBack = { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            } else {
                print("没有可以返回的页面")
            }
        }
        
        if let url = URL(string: "https://www.80qishu.com/") { // 替换为小说下载页面的 URL
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    @objc private func actions(_ button: ASButtonNode) {

    }
    
    override func containerLayoutUpdated(_ layout: ContainerViewLayout, navigationHeight: CGFloat, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, navigationHeight: navigationHeight, transition: transition)
        
        let toolBarNodeSize = self.toolBarNode.containerLayoutUpdated(.zero, size: layout.size, transition: transition)
        let toolBarNodeFrame = CGRect(x: 0, y: layout.size.height - toolBarNodeSize.height, width: layout.size.width, height: toolBarNodeSize.height)
        let webViewFrame = CGRect(x: 0, y: navigationHeight, width: layout.size.width, height: toolBarNodeFrame.minY - navigationHeight)
        
        transition.updateFrame(view: self.webView, frame: webViewFrame)
        transition.updateFrame(node: self.toolBarNode, frame: toolBarNodeFrame)
    }
}

extension WebControllerNode: WKNavigationDelegate {
    // MARK: - WKNavigationDelegate 方法拦截请求
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
          if let url = navigationAction.request.url {
              if url.pathExtension == "txt" || url.pathExtension == "epub" { // 检查文件类型
                  FileDownload.downloadFile(from: url)
                  decisionHandler(.cancel) // 取消 WebView 默认加载行为
                  return
              }
          }
          decisionHandler(.allow) // 继续加载
      }    
}

private class WebToolbarNode: BaseDisplayNode {
    private let backNode: ASButtonNode
    
    var webGoBack: (()->())?
        
    override init(context: any AccountContext, presentationData: PresentationData) {
        self.backNode = ASButtonNode()
        self.backNode.setTitle("返回", with: Font.semibold(15), with: .black, for: .normal)
        super.init(context: context, presentationData: presentationData)
        
        self.backNode.addTarget(self, action: #selector(self.actions(_:)), forControlEvents: .touchUpInside)
        self.addSubnode(self.backNode)
    }
    
    @objc private func actions(_ button: ASButtonNode) {
        self.webGoBack?()
    }
    
    override func updatePresentationData(presentationData: PresentationData) {
        super.updatePresentationData(presentationData: presentationData)
        self.backgroundColor = .lightGray
    }
    
    override func containerLayoutUpdated(_ insets: UIEdgeInsets, size: CGSize, transition: ContainedViewLayoutTransition) -> CGSize {
        super.containerLayoutUpdated(insets, size: size, transition: transition)
        
        let nodeHeight: CGFloat = 44.0
        
        let backNodeFrame = CGRect(x: 20, y: (nodeHeight - 30) / 2.0, width: 70, height: 30)
        transition.updateFrame(node: self.backNode, frame: backNodeFrame)
        
        return CGSize(width: size.width, height: nodeHeight)
    }
}
