//
//  DefaultDayPresentationTheme.swift
//  BeWordsPresentationData
//
//  Created by apple on 2024/3/8.
//

import UIKit

public let defaultDayPresentationTheme = makeDefaultDayPresentationTheme()
private let defaultDayAccentColor = UIColor(rgb: 0x007aff)

public func makeDefaultDayPresentationTheme() -> PresentationTheme {
    let rootNavigationBar = PresentationThemeRootNavigationBar(
        buttonColor: defaultDayAccentColor,
        disabledButtonColor: UIColor(rgb: 0xd0d0d0),
        primaryTextColor: UIColor(rgb: 0x000000),
        secondaryTextColor: UIColor(rgb: 0x787878),
        controlColor: UIColor(rgb: 0x7e8791),
        accentTextColor: defaultDayAccentColor,
        blurredBackgroundColor: UIColor(rgb: 0xf2f2f2, alpha: 0.9),
        opaqueBackgroundColor: UIColor(rgb: 0xf7f7f7).mixedWith(.white, alpha: 0.14),
        separatorColor: UIColor(rgb: 0xc8c7cc),
        badgeBackgroundColor: UIColor(rgb: 0xff3b30),
        badgeStrokeColor: UIColor(rgb: 0xff3b30),
        badgeTextColor: UIColor(rgb: 0xffffff),
        segmentedBackgroundColor: UIColor(rgb: 0x000000, alpha: 0.06),
        segmentedForegroundColor: UIColor(rgb: 0xf7f7f7),
        segmentedTextColor: UIColor(rgb: 0x000000),
        segmentedDividerColor: UIColor(rgb: 0xd6d6dc),
        clearButtonBackgroundColor: UIColor(rgb: 0xE3E3E3, alpha: 0.78),
        clearButtonForegroundColor: UIColor(rgb: 0x7f7f7f)
    )
            
    let rootController = PresentationThemeRootController(
        statusBarStyle: .black,
        navigationBar: rootNavigationBar,
        keyboardColor: .light
    )
    
    let textTheme = PresentationThemeText(
        primaryColor: UIColor(rgb: 0x333333),
        secondaryColor: UIColor(rgb: 0x666666),
        destructiveColor: UIColor(rgb: 0x999999)
    )
    
    let backgroundTheme = PresentationThemeBackground(
        backgroundColor: UIColor(rgb: 0xf0f0f7),
        primaryBackgroundColor: UIColor(rgb: 0xffffff),
        secondaryBackgroundColor: UIColor(rgb: 0xF1F3F5),
        thirdNatureBackgroundColor: UIColor(rgb: 0xEBEBF2),
        fourthBackgroundColor: UIColor(rgb: 0xF8F9FA), 
        fifthBackgroundColor: UIColor(rgb: 0xCCCCCC),
        itemBackgroundColor: UIColor(rgb: 0xF7F7FA),
        lightBackgroundColor: UIColor(rgb: 0xF2F2F7)
    )
    
    let general = PresentationThemeGeneral(
        mainColor: UIColor(rgb: 0x5B6CD8),
        separateLineColor: UIColor(rgb: 0xF2F2F2),
        inputBackgroundColor: UIColor(rgb: 0xE1E4F0), 
        textTheme: textTheme, 
        backgroundTheme: backgroundTheme
    )
    
    return PresentationTheme(
        name: .custom(.day),
        index: 0,
        rootController: rootController,
        general: general
    )
}
