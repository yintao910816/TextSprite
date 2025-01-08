//
//  AccountContext.swift
//  TextSprite
//
//  Created by apple on 2025/1/7.
//

import SwiftSignalKitTG
import TGSubmodoules

public protocol AccountContext {
    var mainWindow: Window1? { get }

    var currentPresentationData: Atomic<PresentationData> { get }
    var presentationData: Signal<PresentationData, NoError> { get }        
}
