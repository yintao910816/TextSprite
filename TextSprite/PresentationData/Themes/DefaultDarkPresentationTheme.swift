//
//  DefaultDayPresentationTheme.swift
//  BeWordsPresentationData
//
//  Created by apple on 2024/3/8.
//

import UIKit

public let defaultDarkPresentationTheme = makeDefaultDarkPresentationTheme()
public let defaultDarkAccentColor = UIColor(rgb: 0x5B6CD8)

public func makeDefaultDarkPresentationTheme() -> PresentationTheme {
    let rootNavigationBar = PresentationThemeRootNavigationBar(
        buttonColor: UIColor(rgb: 0xffffff),
        disabledButtonColor: UIColor(rgb: 0x525252),
        primaryTextColor: UIColor(rgb: 0xffffff),
        secondaryTextColor: UIColor(rgb: 0xffffff, alpha: 0.5),
        controlColor: UIColor(rgb: 0x767676),
        accentTextColor: UIColor(rgb: 0xffffff),
        blurredBackgroundColor: UIColor(rgb: 0x1d1d1d, alpha: 0.9),
        opaqueBackgroundColor: UIColor(rgb: 0x1d1d1d).mixedWith(UIColor(rgb: 0x000000), alpha: 0.1),
        separatorColor: UIColor(rgb: 0x545458, alpha: 0.55),
        badgeBackgroundColor:  UIColor(rgb: 0xffffff),
        badgeStrokeColor: UIColor(rgb: 0x1c1c1d),
        badgeTextColor:  UIColor(rgb: 0x000000),
        segmentedBackgroundColor: UIColor(rgb: 0x3a3b3d),
        segmentedForegroundColor: UIColor(rgb: 0x6f7075),
        segmentedTextColor: UIColor(rgb: 0xffffff),
        segmentedDividerColor: UIColor(rgb: 0x505155),
        clearButtonBackgroundColor: UIColor(rgb: 0xffffff, alpha: 0.1),
        clearButtonForegroundColor: UIColor(rgb: 0xffffff)
    )
            
    let rootController = PresentationThemeRootController(
        statusBarStyle: .white,
        navigationBar: rootNavigationBar,
        keyboardColor: .dark
    )
    
    let textTheme = PresentationThemeText(
        primaryColor: UIColor(rgb: 0xB6B6B8),
        secondaryColor: UIColor(rgb: 0x87878C),
        destructiveColor: UIColor(rgb: 0x686873)
    )
    
    let backgroundTheme = PresentationThemeBackground(
        backgroundColor: UIColor(rgb: 0x000000),
        primaryBackgroundColor: UIColor(rgb: 0x232329),
        secondaryBackgroundColor: UIColor(rgb: 0x323238),
        thirdNatureBackgroundColor: UIColor(rgb: 0xEBEBF2),
        fourthBackgroundColor: UIColor(rgb: 0x3D3D47),
        fifthBackgroundColor: UIColor(rgb: 0xCCCCCC),
        itemBackgroundColor: UIColor.darkGray,
        lightBackgroundColor: UIColor(rgb: 0xF2F2F7)
    )

    let general = PresentationThemeGeneral(
        mainColor: UIColor(rgb: 0x5B6CD8),
        separateLineColor: UIColor(rgb: 0x494953),
        inputBackgroundColor: UIColor(rgb: 0xE1E4F0), 
        textTheme: textTheme, 
        backgroundTheme: backgroundTheme
    )
    
    return PresentationTheme(
        name: .custom(.dark),
        index: 4,
        rootController: rootController,
        general: general
    )
}
