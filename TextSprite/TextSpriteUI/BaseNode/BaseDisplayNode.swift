//
//  BaseDisplayNode.swift
//  TextSprite
//
//  Created by apple on 2025/1/8.
//

import TGSubmodoules

public class BaseDisplayNode: ASDisplayNode {
 
    var presentationData: PresentationData
    let context: AccountContext
    
    var applyLayout: (()->())?
    var containerLayout: (insets: UIEdgeInsets, size: CGSize, transition: ContainedViewLayoutTransition)?
    var layoutAndTransition: (ContainerViewLayout, navigationHeight: CGFloat, ContainedViewLayoutTransition)?

    init(context: AccountContext, presentationData: PresentationData) {
        self.presentationData = presentationData
        self.context = context
        super.init()
        self.updatePresentationData(presentationData: presentationData)
        
        self.applyLayout = { [weak self] in
            guard let self else { return }
            if let (insets, size, transition) = self.containerLayout {
                self.containerLayoutUpdated(insets, size: size, transition: transition)
            }
        }
    }
    
    deinit {
        debugPrint("\n*** 👌👌👌👌👌👌 \(self) deinit 👌👌👌👌👌👌 ***")
    }
    
    func updatePresentationData(presentationData: PresentationData) {
        self.presentationData = presentationData
        
        let theme = presentationData.theme
        self.backgroundColor = theme.general.backgroundTheme.backgroundColor
        
        if let (insets, size, transition) = self.containerLayout {
            self.containerLayoutUpdated(insets, size: size, transition: transition)
        }
    }

    @discardableResult
    func containerLayoutUpdated(_ insets: UIEdgeInsets, size: CGSize, transition: ContainedViewLayoutTransition) ->CGSize {
        self.containerLayout = (insets, size, transition)
        return .zero
    }
    
    @discardableResult
    func customContainerLayoutUpdated(_ layout: ContainerViewLayout, navigationHeight: CGFloat, transition: ContainedViewLayoutTransition) ->CGSize {
        self.layoutAndTransition = (layout, navigationHeight, transition)
        return .zero
    }

    func containerLayoutUpdated(_ layout: ContainerViewLayout, navigationHeight: CGFloat, transition: ContainedViewLayoutTransition) {
        self.layoutAndTransition = (layout, navigationHeight, transition)
    }
    
}
