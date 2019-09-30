//
//  ToasterAppearance.swift
//  toasterApp
//
//  Created by Andrei Nedov on 16/09/2019.
//  Copyright © 2019 Andrei Nedov. All rights reserved.
//

import UIKit

public protocol ToasterAppearance: class {
    
    static var shared: Self { get set }
    
    init()
    
    // Color
    var isBlurView: Bool { get set } /// если true, цвета неактивны
    var successColor: UIColor { get set }
    var warningColor: UIColor { get set }
    var errorColor: UIColor { get set }
    
    // TextLabel
    var textFont: UIFont { get set }
    var textColor: UIColor { get set }
    var numberOfLines: Int { get set }
    var textAlignment: NSTextAlignment { get set }
    var textLineBreakMode: NSLineBreakMode { get set }
    
    // NotificationView`
    var animationDuration: TimeInterval  { get set }
    var intervalTime: TimeInterval { get set }
    var isStatusBarHidden: Bool { get set }
    var isShowToastSingle: Bool { get set }
}
