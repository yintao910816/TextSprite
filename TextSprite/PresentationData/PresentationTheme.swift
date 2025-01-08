//
//  PresentationTheme.swift
//  BeWordsPresentationData
//
//  Created by apple on 2024/3/8.
//

import UIKit
import TGSubmodoules

public enum PresentationThemeCustomName: String {
    case day = "day"
    case dark = "dark"
}

public enum SystemThemeType: Int {
    case light = 0
    case dark = 1
}

public enum PresentationThemeName: Equatable {
    case system(type: SystemThemeType)
    case custom(PresentationThemeCustomName)

    public static func ==(lhs: PresentationThemeName, rhs: PresentationThemeName) -> Bool {
        switch lhs {
        case let .system(lhsType):
            switch rhs {
            case let .system(rhsType):
                return lhsType == rhsType
            case .custom:
                return false
            }
        case .custom(let lhsName):
            switch rhs {
            case .system:
                return false
            case .custom(let rhsName):
                if lhsName != rhsName {
                    return false
                }
                return true
            }
        }
    }
}

public enum PresentationThemeStatusBarStyle: Int32 {
    case black = 0
    case white = 1
    
    init(_ style: StatusBarStyle) {
        switch style {
            case .White:
                self = .white
            default:
                self = .black
        }
    }
    
    public var style: StatusBarStyle {
        switch self {
            case .black:
                return .Black
            case .white:
                return .White
        }
    }
}


public final class PresentationThemeRootNavigationBar {
    public let buttonColor: UIColor
    public let disabledButtonColor: UIColor
    public let primaryTextColor: UIColor
    public let secondaryTextColor: UIColor
    public let controlColor: UIColor
    public let accentTextColor: UIColor
    public let blurredBackgroundColor: UIColor
    public let opaqueBackgroundColor: UIColor
    public let separatorColor: UIColor
    public let badgeBackgroundColor: UIColor
    public let badgeStrokeColor: UIColor
    public let badgeTextColor: UIColor
    public let segmentedBackgroundColor: UIColor
    public let segmentedForegroundColor: UIColor
    public let segmentedTextColor: UIColor
    public let segmentedDividerColor: UIColor
    public let clearButtonBackgroundColor: UIColor
    public let clearButtonForegroundColor: UIColor
    
    public init(buttonColor: UIColor, disabledButtonColor: UIColor, primaryTextColor: UIColor, secondaryTextColor: UIColor, controlColor: UIColor, accentTextColor: UIColor, blurredBackgroundColor: UIColor, opaqueBackgroundColor: UIColor, separatorColor: UIColor, badgeBackgroundColor: UIColor, badgeStrokeColor: UIColor, badgeTextColor: UIColor, segmentedBackgroundColor: UIColor, segmentedForegroundColor: UIColor, segmentedTextColor: UIColor, segmentedDividerColor: UIColor, clearButtonBackgroundColor: UIColor, clearButtonForegroundColor: UIColor) {
        self.buttonColor = buttonColor
        self.disabledButtonColor = disabledButtonColor
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.controlColor = controlColor
        self.accentTextColor = accentTextColor
        self.blurredBackgroundColor = blurredBackgroundColor
        self.opaqueBackgroundColor = opaqueBackgroundColor
        self.separatorColor = separatorColor
        self.badgeBackgroundColor = badgeBackgroundColor
        self.badgeStrokeColor = badgeStrokeColor
        self.badgeTextColor = badgeTextColor
        self.segmentedBackgroundColor = segmentedBackgroundColor
        self.segmentedForegroundColor = segmentedForegroundColor
        self.segmentedTextColor = segmentedTextColor
        self.segmentedDividerColor = segmentedDividerColor
        self.clearButtonBackgroundColor = clearButtonBackgroundColor
        self.clearButtonForegroundColor = clearButtonForegroundColor
    }
    
    public func withUpdated(buttonColor: UIColor? = nil, disabledButtonColor: UIColor? = nil, primaryTextColor: UIColor? = nil, secondaryTextColor: UIColor? = nil, controlColor: UIColor? = nil, accentTextColor: UIColor? = nil, blurredBackgroundColor: UIColor? = nil, opaqueBackgroundColor: UIColor? = nil, separatorColor: UIColor? = nil, badgeBackgroundColor: UIColor? = nil, badgeStrokeColor: UIColor? = nil, badgeTextColor: UIColor? = nil, segmentedBackgroundColor: UIColor? = nil, segmentedForegroundColor: UIColor? = nil, segmentedTextColor: UIColor? = nil, segmentedDividerColor: UIColor? = nil, clearButtonBackgroundColor: UIColor? = nil, clearButtonForegroundColor: UIColor? = nil) -> PresentationThemeRootNavigationBar {
        let resolvedClearButtonBackgroundColor = clearButtonBackgroundColor ?? self.clearButtonBackgroundColor
        let resolvedClearButtonForegroundColor = clearButtonForegroundColor ?? self.clearButtonForegroundColor
        return PresentationThemeRootNavigationBar(buttonColor: buttonColor ?? self.buttonColor, disabledButtonColor: disabledButtonColor ?? self.disabledButtonColor, primaryTextColor: primaryTextColor ?? self.primaryTextColor, secondaryTextColor: secondaryTextColor ?? self.secondaryTextColor, controlColor: controlColor ?? self.controlColor, accentTextColor: accentTextColor ?? self.accentTextColor, blurredBackgroundColor: blurredBackgroundColor ?? self.blurredBackgroundColor, opaqueBackgroundColor: opaqueBackgroundColor ?? self.opaqueBackgroundColor, separatorColor: separatorColor ?? self.separatorColor, badgeBackgroundColor: badgeBackgroundColor ?? self.badgeBackgroundColor, badgeStrokeColor: badgeStrokeColor ?? self.badgeStrokeColor, badgeTextColor: badgeTextColor ?? self.badgeTextColor, segmentedBackgroundColor: segmentedBackgroundColor ?? self.segmentedBackgroundColor, segmentedForegroundColor: segmentedForegroundColor ?? self.segmentedForegroundColor, segmentedTextColor: segmentedTextColor ?? self.segmentedTextColor, segmentedDividerColor: segmentedDividerColor ?? self.segmentedDividerColor, clearButtonBackgroundColor: resolvedClearButtonBackgroundColor, clearButtonForegroundColor: resolvedClearButtonForegroundColor)
    }
}

public enum PresentationThemeKeyboardColor: Int32 {
    case light = 0
    case dark = 1
    
    public var keyboardAppearance: UIKeyboardAppearance {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

public final class PresentationThemeRootController {
    public let statusBarStyle: PresentationThemeStatusBarStyle
    public let navigationBar: PresentationThemeRootNavigationBar
    public let keyboardColor: PresentationThemeKeyboardColor
    
    public init(statusBarStyle: PresentationThemeStatusBarStyle, navigationBar: PresentationThemeRootNavigationBar, keyboardColor: PresentationThemeKeyboardColor) {
        self.statusBarStyle = statusBarStyle
        self.navigationBar = navigationBar
        self.keyboardColor = keyboardColor
    }
    
    public func withUpdated(statusBarStyle: PresentationThemeStatusBarStyle? = nil, navigationBar: PresentationThemeRootNavigationBar? = nil, keyboardColor: PresentationThemeKeyboardColor? = nil) -> PresentationThemeRootController {
        return PresentationThemeRootController(statusBarStyle: statusBarStyle ?? self.statusBarStyle, navigationBar: navigationBar ?? self.navigationBar, keyboardColor: keyboardColor ?? self.keyboardColor)
    }
}

//MARK: 通用配色
// 文字
public final class PresentationThemeText {
    public let primaryColor: UIColor
    public let secondaryColor: UIColor
    public let destructiveColor: UIColor
    
    init(primaryColor: UIColor, secondaryColor: UIColor, destructiveColor: UIColor) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.destructiveColor = destructiveColor
    }
}

// 背景
public final class PresentationThemeBackground {
    public let backgroundColor: UIColor
    public let primaryBackgroundColor: UIColor
    public let secondaryBackgroundColor: UIColor
    public let thirdNatureBackgroundColor: UIColor
    public let fourthBackgroundColor: UIColor
    public let fifthBackgroundColor: UIColor
    public let itemBackgroundColor: UIColor
    public let lightBackgroundColor: UIColor

    public init(backgroundColor: UIColor, primaryBackgroundColor: UIColor, secondaryBackgroundColor: UIColor, thirdNatureBackgroundColor: UIColor, fourthBackgroundColor: UIColor, fifthBackgroundColor: UIColor, itemBackgroundColor: UIColor, lightBackgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.primaryBackgroundColor = primaryBackgroundColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.thirdNatureBackgroundColor = thirdNatureBackgroundColor
        self.fourthBackgroundColor = fourthBackgroundColor
        self.fifthBackgroundColor = fifthBackgroundColor
        self.itemBackgroundColor = itemBackgroundColor
        self.lightBackgroundColor = lightBackgroundColor
    }
}

public final class PresentationThemeGeneral {
    public let mainColor: UIColor
    
    public let separateLineColor: UIColor
    /// 输入框背景颜色
    public let inputBackgroundColor: UIColor

    public let textTheme: PresentationThemeText
    public let backgroundTheme: PresentationThemeBackground

    init(mainColor: UIColor, separateLineColor: UIColor, inputBackgroundColor: UIColor, textTheme: PresentationThemeText, backgroundTheme: PresentationThemeBackground) {
        self.mainColor = mainColor
        self.separateLineColor = separateLineColor
        self.inputBackgroundColor = inputBackgroundColor
        self.textTheme = textTheme
        self.backgroundTheme = backgroundTheme
    }
}

//MARK: 各模块配色初始化
public final class PresentationTheme: Equatable {
    public let name: PresentationThemeName
    public let index: Int64
    public let rootController: PresentationThemeRootController
    public let general: PresentationThemeGeneral

    public init(name: PresentationThemeName, index: Int64, rootController: PresentationThemeRootController, general: PresentationThemeGeneral) {
        self.name = name
        self.index = index
        self.rootController = rootController
        self.general = general
    }
    
    public static func ==(lhs: PresentationTheme, rhs: PresentationTheme) -> Bool {
        return lhs === rhs
    }
}
