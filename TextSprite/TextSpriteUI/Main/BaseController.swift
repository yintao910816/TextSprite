//
//  BaseController.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import TGSubmodoules

public struct NavigationBarParameters {
    let hideBackground: Bool
    let hideSeparator: Bool
    let hideBadge: Bool

    public init(hideBackground: Bool, hideSeparator: Bool, hideBadge: Bool = true) {
        self.hideBackground = hideBackground
        self.hideBadge = hideBadge
        self.hideSeparator = hideSeparator
    }
}

public class BaseController: ViewController {
    public var context: AccountContext
    public var presentationData: PresentationData
    
    private var navigationBarParameters: NavigationBarParameters?
    
    public init(context: AccountContext, navigationBarParameters: NavigationBarParameters?) {
        self.context = context
        self.presentationData = context.currentPresentationData.with { $0 }
        self.navigationBarParameters = navigationBarParameters
        
        let navigationBarPresentationData: NavigationBarPresentationData?
        if let parameters = navigationBarParameters {
            navigationBarPresentationData = NavigationBarPresentationData(presentationData: self.presentationData,
                                                                          hideBackground: parameters.hideBackground,
                                                                          hideBadge: parameters.hideBadge,
                                                                          hideSeparator: parameters.hideSeparator)

        }else {
            navigationBarPresentationData = nil
        }

        super.init(navigationBarPresentationData: navigationBarPresentationData)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
