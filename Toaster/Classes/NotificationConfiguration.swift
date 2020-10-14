//
//  DefaultNotificationAppearance.swift
//  Toaster
//
//  Created by Andrei Nedov on 25/09/2019.
//

import UIKit

/// Конфигурция отображения нотификации.
public struct NotificationConfiguration {
    
    
    // MARK: - Public Properties
    
    /// Время анимации
    public var animationDuration: TimeInterval = 0.3
    
    /// Время отображения нотфикации
    public var intervalTime: TimeInterval = 4
    
    /// Накладывать нотификации друг на друга
    public var isShowToastSingle: Bool = true
    
    /// Цвет статус бара
    public var isStatusBarLight: Bool = true
    
    /// Скрывать статус бар или нет, актуально на iOS 12 и ниже
    public var isStatusBarHidden: Bool = false
    
    /// Отступы view от границ экрана
    public var insets: UIEdgeInsets = .zero
    
    // MARK: - Private Properties

    var statusBarHidden: UIWindow.Level {
        switch isStatusBarHidden {
        case true:
            return UIWindow.Level.alert
        case false:
            return UIWindow.Level.statusBar - 1
        }
    }
    
    var statusBarLight: UIStatusBarStyle {
        switch isStatusBarLight {
        case true:
            return .lightContent
        case false:
            return .default
        }
    }
}
