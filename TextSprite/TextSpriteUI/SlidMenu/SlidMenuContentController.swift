//
//  SlidMenuContentController.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import TGSubmodoules
import SwiftSignalKitTG

public class SlidMenuContentController: BaseController {
    
    private var controllerNode: SlidMenuContentControllerNode {
        return self.displayNode as! SlidMenuContentControllerNode
    }

    public override init(context: any AccountContext, navigationBarParameters: NavigationBarParameters?) {
        super.init(context: context, navigationBarParameters: navigationBarParameters)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadDisplayNode() {
        self.displayNode = SlidMenuContentControllerNode(context: self.context, presentationData: self.presentationData)
        self.displayNode.backgroundColor = .lightGray
        self.displayNodeDidLoad()
    }
    
    public override func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
    }
}
