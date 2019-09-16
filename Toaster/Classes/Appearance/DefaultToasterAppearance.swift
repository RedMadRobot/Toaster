//
//  ToasterAppearance.swift
//  toasterApp
//
//  Created by Andrei Nedov on 15/09/2019.
//  Copyright © 2019 Andrei Nedov. All rights reserved.
//

import UIKit

public final class NotificationAppearance: ToasterAppearance {

    public static var shared: NotificationAppearance = .init()

    required init() {}
    
    public var isBlurView: Bool = false
    public var successColor: UIColor = .green
    public var warningColor: UIColor = .yellow
    public var errorColor: UIColor = .red
    public var textFont: UIFont = .systemFont(ofSize: 16)
    public var textColor: UIColor = .white
    public var numberOfLines: Int = 0
    public var textAlignment: NSTextAlignment = .center
    public var textLineBreakMode: NSLineBreakMode = .byWordWrapping
    public var animationDuration: TimeInterval = 0.3
    public var intervalTime: TimeInterval = 4
    public var isStatusBarHidden: Bool = false
    public var isShowToastSingle: Bool = true
}
