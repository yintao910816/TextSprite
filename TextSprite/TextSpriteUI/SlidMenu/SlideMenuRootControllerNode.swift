//
//  SlideMenuRootControllerNode.swift
//  TextSprite
//
//  Created by apple on 2025/1/8.
//

import TGSubmodoules

enum SlideMenuTransitionResult {
    case update(CGFloat)
    case compelement
    case fastHidden
    case fastShow
}

class SlideMenuRootControllerNode: BaseDisplayNode {
    private var gesture: InteractiveTransitionGestureRecognizer?
    private var lastTranslationX: CGFloat = 0
    
    private let interaction: SlideMenuRootControllerInteraction
    
    init(context: any AccountContext, presentationData: PresentationData, interaction: SlideMenuRootControllerInteraction) {
        self.interaction = interaction
        super.init(context: context, presentationData: presentationData)
        
        self.gesture = InteractiveTransitionGestureRecognizer(target: self, action: #selector(self.panGesture(_:)), allowedDirections: { _ in
            return [.left, .right]
        }, edgeWidth: .constant(0))

        self.view.addGestureRecognizer(self.gesture!)
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {        
        switch recognizer.state {
        case .began:
            break
        case .changed:
            let translation = recognizer.translation(in: self.view)
            let deltaX = translation.x
            self.interaction.transitionLocationChange(.update(deltaX))
        case .cancelled, .ended:
            let velocity = recognizer.velocity(in: self.view)
            debugPrint("==== \(velocity.x)")
            if velocity.x <= -500 {
                self.interaction.transitionLocationChange(.fastHidden)
            }else if velocity.x >= 500 {
                self.interaction.transitionLocationChange(.fastShow)
            }else {
                self.interaction.transitionLocationChange(.compelement)
            }
        default:
            break
        }
        recognizer.setTranslation(.zero, in: self.view)
    }

    override func containerLayoutUpdated(_ layout: ContainerViewLayout, navigationHeight: CGFloat, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, navigationHeight: navigationHeight, transition: transition)
    }
}
