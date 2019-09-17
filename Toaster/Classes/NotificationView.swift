//
//  NotificationView.swift
//
//  Created by Andrei Nedov on 16/09/2019.
//  Copyright © 2019 Andrei Nedov. All rights reserved.
//

import UIKit

///Текущая реализация протокола ToasterAppearance
public typealias DefaultAppearance = NotificationAppearance

/// Тип нотификации для пользователя.
public enum FeedbackType {
    case success
    case warning
    case error
}
/// Нотификация для пользователя.
public struct FeedbackNotification: Equatable {
    
    /// Тип нотификации.
    public var type: FeedbackType
    /// Тест обратной нотификации.
    public var text: String
    
    public init(type: FeedbackType, text: String){
        self.type = type
        self.text = text
    }
}

public extension FeedbackNotification {

    static let somethingWentWrong = FeedbackNotification(type: .error, text: "Что-то пошло не так")
    static let notConnectedToInternet = FeedbackNotification(type: .error, text: "Нет соединения с интернетом")
    static let pleaseTryLater = FeedbackNotification(type: .error, text: "Ошибка, попробуйте позже")
}

public protocol NotificationPresentable {
    
    func showFeedback(_ type: FeedbackType, _ text: String)

    func showFeedback(_ notification: FeedbackNotification)

    func showFeedback(with error: Error)
}

public extension NotificationPresentable {
    
    func showFeedback(with error: Error) {
        switch error {
        case is URLError:
            showFeedback(.notConnectedToInternet)
        default:
            showFeedback(.somethingWentWrong)
        }
    }
    
    func showFeedback(_ type: FeedbackType, _ text: String) {
        showFeedback(FeedbackNotification(type: type, text: text))
    }
    
    func showFeedback(_ notification: FeedbackNotification) {
        let notificationView = NotificationView<DefaultAppearance>()
        notificationView.configure(notification)
        NotificationWindowController.shared.show(notificationView, with: notification)
    }
}

// MARK: - Private

/// Значение UIWindow.Level для скрытия или показа статус бара
private enum ToastSettings {
    
    enum StatusBar{
        
        case appearance(DefaultAppearance)
        func level() -> UIWindow.Level {
            switch self {
            case .appearance(let current):
                switch current.isStatusBarHidden{
                case true:
                    return UIWindow.Level.alert
                case false:
                    return UIWindow.Level.statusBar - 1
                }
            }
        }
    }
}

private final class NotificationView<A>: UIView where A: ToasterAppearance{
    
    let appearance: A = A.shared
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = self.appearance.textFont
        textLabel.numberOfLines = self.appearance.numberOfLines
        textLabel.textAlignment = self.appearance.textAlignment
        textLabel.lineBreakMode = self.appearance.textLineBreakMode
        textLabel.textColor = self.appearance.textColor
        textLabel.accessibilityIdentifier = "notification_text"
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        accessibilityIdentifier = "notification_view"
        
        if appearance.isBlurView {
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            blurView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(blurView)
            self.topAnchor.constraint(equalTo: blurView.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: blurView.bottomAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: blurView.leadingAnchor).isActive = true
            blurView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 16, right: 24)
            
            let topAnchor = textLabel.topAnchor.constraint(equalTo: blurView.layoutMarginsGuide.topAnchor)
            topAnchor.priority = .defaultHigh
            blurView.contentView.addSubview(textLabel)
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            topAnchor.isActive = true
            textLabel.topAnchor.constraint(greaterThanOrEqualTo: blurView.topAnchor, constant: 16).isActive = true
            textLabel.bottomAnchor.constraint(equalTo: blurView.layoutMarginsGuide.bottomAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: blurView.layoutMarginsGuide.leadingAnchor).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: blurView.layoutMarginsGuide.trailingAnchor).isActive = true
        }else{
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(textLabel)
            textLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
            textLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        }
    }
    
    func configure(_ notification: FeedbackNotification) {
        self.textLabel.text = notification.text
        let feedbackGenerator = UINotificationFeedbackGenerator()
        switch notification.type {
        case .success:
            backgroundColor = appearance.isBlurView ? .clear : appearance.successColor
            feedbackGenerator.notificationOccurred(.success)
        case .warning:
            backgroundColor = appearance.isBlurView ? .clear : appearance.warningColor
            feedbackGenerator.notificationOccurred(.warning)
        case .error:
            backgroundColor = appearance.isBlurView ? .clear : appearance.errorColor
            feedbackGenerator.notificationOccurred(.error)
        }
    }
}

/// Окно нотификаций.
private final class NotificationWindow: UIWindow {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Отрабатваем только нажатия на уведомление, чтобы окно не перекрыло собой приложение.
        let hitView = super.hitTest(point, with: event)
        if hitView == self || hitView == rootViewController?.view {
            return nil
        }
        return hitView
    }
}

private final class NotificationViewController: UIViewController {
    // Используем контроллер, чтобы установить цвет статус бара, а то он будет чёрный.
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

/// Контроллер окна нотификаций.
///
/// - Note: Открыт для тестирования.
public class WindowController<A> where A: ToasterAppearance {
    
    let appearance: A = A.shared
}

public final class NotificationWindowController: WindowController<DefaultAppearance>{
    
    private enum Direction {
        case up
        case down
    }
    
    public static let shared = NotificationWindowController()
    
    public var view: UIView { return window.rootViewController!.view }
    
    private lazy var animationDuration: TimeInterval = self.appearance.animationDuration
    
    private(set) var currentFeedbackNotification: FeedbackNotification?
    private weak var currentNotificationView: UIView?
    
    private lazy var window: UIWindow = {
        let window = NotificationWindow(frame: UIScreen.main.bounds)
        window.layer.speed = UIApplication.shared.keyWindow!.layer.speed
        window.rootViewController = NotificationViewController()
        window.windowLevel = ToastSettings.StatusBar.appearance(self.appearance).level()
        window.backgroundColor = .clear
        window.accessibilityIdentifier = "notification_window"
        window.isHidden = false
        return window
    }()
    
    private override init() {}
    
    public func show(_ view: UIView, with feedbackNotification: FeedbackNotification?) {
        currentFeedbackNotification = feedbackNotification
        
        if appearance.isShowToastSingle{
            addNotificationView(view)
        }else{
            addSubview(view)
            move(view, to: .up)
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        view.addGestureRecognizer(pan)
        
        animateMove(view, to: .down)
        DispatchQueue.main.asyncAfter(deadline: .now() + appearance.intervalTime) {
            if self.currentFeedbackNotification == feedbackNotification {
                self.currentFeedbackNotification = nil
            }
            guard view.superview != nil else {
                return
            }
            self.hideUp(view)
        }
    }
    
    // MARK: - Private
    
    private func addNotificationView(_ notificationView: UIView) {
        if let currentView = currentNotificationView {
            hideUp(currentView)
        }
        currentNotificationView = notificationView
        addSubview(notificationView)
        move(notificationView, to: .up)
    }
    
    private func updateWindow() {
        self.window.isHidden = self.view.subviews.isEmpty
    }
    
    private func addSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        subview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        subview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        subview.layoutIfNeeded()
        updateWindow()
    }
    
    private func move(_ view: UIView, to direction: Direction) {
        switch direction {
        case .up:
            view.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        case .down:
            view.transform = .identity
        }
    }
    
    private func animateMove(_ view: UIView, to direction: Direction, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: { self.move(view, to: direction) },
            completion: completion)
    }
    
    private func hideUp(_ view: UIView) {
        animateMove(view, to: .up) { _ in
            view.removeFromSuperview()
            self.updateWindow()
        }
    }
    
    // MARK: - Action
    
    @objc private func panAction(_ recognizer: UIPanGestureRecognizer) {
        guard recognizer.state == .began, let view = recognizer.view else {
            return
        }
        // Ускорение вверх
        guard recognizer.velocity(in: view).y < 0 else {
            return
        }
        hideUp(view)
    }
}
