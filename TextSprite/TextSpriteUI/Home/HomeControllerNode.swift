//
//  HomeControllerNode.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import TGSubmodoules

class HomeControllerNode: BaseDisplayNode {
    private let testButton: ASButtonNode
    
    private let interaction: HomeControllerInteraction
    
    init(context: any AccountContext, presentationData: PresentationData, interaction: HomeControllerInteraction) {
        self.interaction = interaction
        
        self.testButton = ASButtonNode()
        self.testButton.setTitle("选择文件", with: Font.semiboldItalic(16), with: .black, for: .normal)
        
        super.init(context: context, presentationData: presentationData)
        
        self.testButton.addTarget(self, action: #selector(self.actions(_:)), forControlEvents: .touchUpInside)
        
        self.addSubnode(self.testButton)
    }
    
    @objc private func actions(_ button: ASButtonNode) {
        self.interaction.testAction()
    }
    
    override func containerLayoutUpdated(_ layout: ContainerViewLayout, navigationHeight: CGFloat, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, navigationHeight: navigationHeight, transition: transition)
        
        let testButtonFrame = CGRect(x: (layout.size.width - 100) / 2.0, y: (layout.size.height - 35) / 2.0, width: 100, height: 35)
        transition.updateFrame(node: self.testButton, frame: testButtonFrame)
    }
}
