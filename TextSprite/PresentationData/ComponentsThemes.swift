import Foundation
import UIKit
import TGSubmodoules

//MARK: 导航栏
public extension NavigationControllerTheme {
    convenience init(presentationTheme: PresentationTheme) {
        let navigationStatusBar: NavigationStatusBarStyle
        switch presentationTheme.rootController.statusBarStyle {
        case .black:
            navigationStatusBar = .black
        case .white:
            navigationStatusBar = .white
        }
        self.init(statusBar: navigationStatusBar, navigationBar: NavigationBarTheme(rootControllerTheme: presentationTheme), emptyAreaColor: .black)
    }
}

public extension NavigationBarTheme {
    convenience init(rootControllerTheme: PresentationTheme, enableBackgroundBlur: Bool = true, hideBackground: Bool = false, hideBadge: Bool = false, hideSeparator: Bool = false) {
        let theme = rootControllerTheme.rootController.navigationBar
        self.init(buttonColor: theme.buttonColor, disabledButtonColor: theme.disabledButtonColor, primaryTextColor: theme.primaryTextColor, backgroundColor: hideBackground ? .clear : theme.blurredBackgroundColor, enableBackgroundBlur: enableBackgroundBlur, separatorColor: hideBackground || hideSeparator ? .clear : theme.separatorColor, badgeBackgroundColor: hideBadge ? .clear : theme.badgeBackgroundColor, badgeStrokeColor: hideBadge ? .clear : theme.badgeStrokeColor, badgeTextColor: hideBadge ? .clear : theme.badgeTextColor)
    }
}

public extension NavigationBarPresentationData {
    convenience init(presentationData: PresentationData) {
        self.init(theme: NavigationBarTheme(rootControllerTheme: presentationData.theme), strings: NavigationBarStrings(back: "返回", close: "关闭"))
    }
    
    convenience init(presentationData: PresentationData, hideBackground: Bool, hideBadge: Bool, hideSeparator: Bool = false) {
        self.init(theme: NavigationBarTheme(rootControllerTheme: presentationData.theme, hideBackground: hideBackground, hideBadge: hideBadge, hideSeparator: hideSeparator), strings: NavigationBarStrings(back: "返回", close: "关闭"))
    }
    
    convenience init(presentationData: PresentationData, backgroundColor: UIColor, hideBackground: Bool, hideBadge: Bool, hideSeparator: Bool = false) {
        let theme = presentationData.theme.rootController.navigationBar
        let barTheme = NavigationBarTheme(buttonColor: theme.buttonColor, disabledButtonColor: theme.disabledButtonColor, primaryTextColor: theme.primaryTextColor, backgroundColor: hideBackground ? .clear : backgroundColor, enableBackgroundBlur: true, separatorColor: hideBackground || hideSeparator ? .clear : theme.separatorColor, badgeBackgroundColor: hideBadge ? .clear : theme.badgeBackgroundColor, badgeStrokeColor: hideBadge ? .clear : theme.badgeStrokeColor, badgeTextColor: hideBadge ? .clear : theme.badgeTextColor)
        self.init(theme: barTheme, strings: NavigationBarStrings(back: "返回", close: "关闭"))
    }
}
