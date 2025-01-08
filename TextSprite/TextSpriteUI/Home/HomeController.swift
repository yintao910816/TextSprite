//
//  HomeController.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import TGSubmodoules
import SwiftSignalKitTG

public class HomeController: BaseController {
    
    private var controllerNode: HomeControllerNode {
        return self.displayNode as! HomeControllerNode
    }

    public override init(context: any AccountContext, navigationBarParameters: NavigationBarParameters?) {
        super.init(context: context, navigationBarParameters: navigationBarParameters)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadDisplayNode() {
        self.displayNode = HomeControllerNode()
        self.displayNode.view.backgroundColor = .blue
        self.displayNodeDidLoad()
    }
    
    public override func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
       print(layout)
    }
}

