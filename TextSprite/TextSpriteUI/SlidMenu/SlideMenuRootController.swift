//
//  SlideMenuRootController.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import TGSubmodoules
import SwiftSignalKitTG

public struct SlideMenuRootControllerInteraction {
//    let transitionFractionChange: (CGFloat)->()
//    let transitionFractionComplement: (CGFloat)->()
//
//    init(transitionFractionChange: @escaping (CGFloat) -> Void, transitionFractionComplement: @escaping (CGFloat) -> Void) {
//        self.transitionFractionChange = transitionFractionChange
//        self.transitionFractionComplement = transitionFractionComplement
//    }
        let transitionLocationChange: (SlideMenuTransitionResult)->()

    init(transitionLocationChange: @escaping (SlideMenuTransitionResult) -> Void) {
        self.transitionLocationChange = transitionLocationChange
    }
}

public class SlideMenuRootController: BaseController {
    private let contentController: SlidMenuContentController
    private let detailContentController: SlidMenuDetailContentController
    
    private var interaction: SlideMenuRootControllerInteraction!
    
    private var currentUpdateX: CGFloat = 0
    
    private var controllerNode: SlideMenuRootControllerNode {
        return self.displayNode as! SlideMenuRootControllerNode
    }

    public required init(context: AccountContext) {
        let presentationData = context.currentPresentationData.with { $0 }

        self.contentController = SlidMenuContentController(context: context, navigationBarParameters: nil)
        self.detailContentController = SlidMenuDetailContentController(mode: .automaticMasterDetail, theme: NavigationControllerTheme(presentationTheme: presentationData.theme))
        
        super.init(context: context, navigationBarParameters: nil)
        
        self.interaction = SlideMenuRootControllerInteraction(transitionLocationChange: { [weak self] in
            self?.transitionLocationChange($0)
        })

        self.addChild(self.contentController)
        self.view.addSubview(self.contentController.view)
        self.addChild(self.detailContentController)
        self.view.addSubview(self.detailContentController.view)
        
        self.detailContentController.setContent(HomeController(context: context, navigationBarParameters: nil))
    }
            
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public override func loadDisplayNode() {
        self.displayNode = SlideMenuRootControllerNode(context: self.context, presentationData: self.presentationData, interaction: self.interaction)
        self.displayNode.view.backgroundColor = .blue
        self.displayNodeDidLoad()
    }
    
    private func transitionLocationChange(_ result: SlideMenuTransitionResult) {
        let currentFrame = self.detailContentController.view.frame
        var updateX: CGFloat
        let transition: ContainedViewLayoutTransition

        switch result {
        case let .update(deltaX):
            updateX = currentFrame.origin.x + deltaX
            updateX = max(0, updateX)
            updateX = min(0.75 * currentFrame.size.width, updateX)
            transition = .immediate
        case .compelement:
            if self.currentUpdateX < 0.3 * currentFrame.size.width {
                updateX = 0
            }else {
                updateX = 0.75 * currentFrame.size.width
            }
            transition = .animated(duration: 0.2, curve: .easeInOut)
        case .fastHidden:
            updateX = 0
            transition = .animated(duration: 0.2, curve: .easeInOut)
        case .fastShow:
            updateX = 0.75 * currentFrame.size.width
            transition = .animated(duration: 0.2, curve: .easeInOut)
        }
        
        self.currentUpdateX = updateX
        transition.updateFrame(view: self.detailContentController.view, frame: CGRect(origin: CGPoint(x: updateX, y: currentFrame.origin.y), size: currentFrame.size))
    }
        
    public override func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
        
        let contentControllerFrame = CGRect(origin: .zero, size: layout.size)
        let detailContentControllerFrame = CGRect(origin: .zero, size: layout.size)
        transition.updateFrame(view: self.contentController.view, frame: contentControllerFrame)
        transition.updateFrame(view: self.detailContentController.view, frame: detailContentControllerFrame)
        
        self.contentController.containerLayoutUpdated(layout, transition: transition)
        self.detailContentController.containerLayoutUpdated(layout, transition: transition)
        
        self.controllerNode.containerLayoutUpdated(layout, navigationHeight: 0, transition: transition)
    }
}
