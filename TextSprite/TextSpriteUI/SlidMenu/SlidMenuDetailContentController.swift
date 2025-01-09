//
//  SlidMenuDetailContentController.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import TGSubmodoules

public class SlidMenuDetailContentController: RootNavigationController {
    
    public override init(mode: NavigationControllerMode, theme: NavigationControllerTheme, isFlat: Bool = false) {
        super.init(mode: mode, theme: theme, isFlat: isFlat)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setContent(_ viewController: ViewController) {
        self.viewControllers = [viewController]
    }    
}
