//
//  AccountContextImpl.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import SwiftSignalKitTG
import TGSubmodoules

public final class AccountContextImpl: AccountContext {
    public let mainWindow: Window1?

    // 通过监听 presentationData 信号，更新 currentPresentationData 中的值
    private let _currentPresentationData: Atomic<PresentationData>
    public var currentPresentationData: Atomic<PresentationData> {
        return self._currentPresentationData
    }

    // 监听 PresentationData 的变化
    private let _presentationData = Promise<PresentationData>()
    public var presentationData: Signal<PresentationData, NoError> {
        return self._presentationData.get()
    }

    public init(mainWindow: Window1?, initialPresentationDataAndSettings: InitialPresentationDataAndSettings) {
        self.mainWindow = mainWindow
        self._currentPresentationData = Atomic(value: initialPresentationDataAndSettings.presentationData)

//        let systemUserInterfaceAndPresentationDataSignal: Signal<PresentationData, NoError> = combineLatest(mainWindow?.systemUserInterfaceStyle ?? .single(.light), .single(initialPresentationDataAndSettings.presentationData) |> then(PresentationDataStateInstance.currentState))
//        |> map({ next ->PresentationData in
//            if case .system = next.1.theme.name {
//                // 主题跟随系统
//                let systemThemeType: SystemThemeType
//                if case .dark = next.0 {
//                    systemThemeType = .dark
//                }else {
//                    systemThemeType = .light
//                }
//                PresentationDataStateInstance.withUpdate(themeSetting: ThemeSettingInfo(themeName: .system(type: systemThemeType)))
//                return next.1.withUpdated(theme: setupTheme(.system(type: systemThemeType)))
//            }else {
//                return next.1
//            }
//        })
        
//        let presentationData: Signal<PresentationData, NoError> = .single(initialPresentationDataAndSettings.presentationData)
//        |> then( systemUserInterfaceAndPresentationDataSignal )

//        self._presentationData.set(presentationData)
        
//        self.presentationDataDisposable.set(
//            (self.presentationData
//             |> deliverOnMainQueue).start(next: { [weak self] next in
//                 if let self {
//                     _ = self.currentPresentationData.modify { current in
//                         return next
//                     }
//                 }
//        }))
    }

    
}
