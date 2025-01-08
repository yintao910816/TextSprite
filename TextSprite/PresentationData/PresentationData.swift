//
//  PresentationData.swift
//  BeWordsPresentationData
//
//  Created by apple on 2024/3/8.
//

import UIKit

public func setupTheme(_ themeName: PresentationThemeName) ->PresentationTheme {
    let theme: PresentationTheme
    switch themeName {
    case let .system(type):
        theme = type == .dark ? makeDefaultDarkPresentationTheme() : makeDefaultDayPresentationTheme()
    case let .custom(name):
        switch name {
        case .day:
            theme = makeDefaultDayPresentationTheme()
        case .dark:
            theme = makeDefaultDarkPresentationTheme()
        }
    }
    return theme
}

public func defaultPresentationData(themeName: PresentationThemeName) -> PresentationData {
    return PresentationData(
        theme: setupTheme(themeName)
    )
}

public final class PresentationData: Equatable {
    public let theme: PresentationTheme
    
    init(theme: PresentationTheme) {
        self.theme = theme
    }
        
    public func withUpdated(theme: PresentationTheme) -> PresentationData {
        return PresentationData(theme: theme)
    }
        
    public static func ==(lhs: PresentationData, rhs: PresentationData) -> Bool {
        return lhs.theme === rhs.theme
    }
}

public final class InitialPresentationDataAndSettings {
    public let presentationData: PresentationData
    
    public init(presentationData: PresentationData) {
        self.presentationData = presentationData
    }
}
