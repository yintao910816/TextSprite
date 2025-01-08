//
//  SlideMenuRootController.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import TGSubmodoules
import SwiftSignalKitTG

public class SlideMenuRootController: BaseController {
    
    private let contentController: SlidMenuContentController
    private let detailContentController: SlidMenuDetailContentController
    
    public required init(context: AccountContext) {
        let presentationData = context.currentPresentationData.with { $0 }

        self.contentController = SlidMenuContentController(context: context, navigationBarParameters: nil)
        self.detailContentController = SlidMenuDetailContentController(mode: .automaticMasterDetail, theme: NavigationControllerTheme(presentationTheme: presentationData.theme))
        
        super.init(context: context, navigationBarParameters: nil)
        
        self.addChild(self.contentController)
        self.view.addSubview(self.contentController.view)

        self.addChild(self.detailContentController)
        self.view.addSubview(self.detailContentController.view)
        
        self.detailContentController.setContent(HomeController(context: context, navigationBarParameters: nil))
    }
            
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public override func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        let contentControllerFrame = CGRect(origin: .zero, size: layout.size)
        let detailContentControllerFrame = CGRect(origin: .zero, size: layout.size)
        transition.updateFrame(view: self.contentController.view, frame: contentControllerFrame)
        transition.updateFrame(view: self.detailContentController.view, frame: detailContentControllerFrame)
        
        self.contentController.containerLayoutUpdated(layout, transition: transition)
        self.detailContentController.containerLayoutUpdated(layout, transition: transition)
    }
}
