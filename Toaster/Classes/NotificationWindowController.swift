//
//  NotificationWindowController.swift
//  Toaster
//
//  Created by Andrei Nedov on 25/09/2019.
//

/// Контроллер окна нотификаций.
public final class NotificationWindowController {
    
    private enum Direction {
        case up
        case down
    }

    
    // MARK: - Public Properties
    
    /// Настройки отображения
    public var configuration = NotificationConfiguration()

    /// Синглтон для управлениями настройками и тестов
    public static let shared = NotificationWindowController()
    
    /// Открыто для тестов
    public var view: UIView { return window.rootViewController!.view }
    
    
    // MARK: - Private Properties
        
    private weak var currentNotificationView: UIView?
    
    /// Вьюшки скрываемые в данный момент времени
    private var hidingViews = [UIView]()
    
    private lazy var window: UIWindow = {
        let window = NotificationWindow(frame: UIScreen.main.bounds)
        window.layer.speed = UIApplication.shared.keyWindow!.layer.speed
        window.rootViewController = NotificationViewController()
        window.windowLevel = configuration.statusBarHidden
        window.backgroundColor = .clear
        window.accessibilityIdentifier = "notification_window"
        window.isHidden = false
        return window
    }()
    
    
    // MARK: - Public methods

    public func show(_ view: UIView) {
        if configuration.isShowToastSingle {
            addNotificationView(view)
        } else {
            currentNotificationView = view
            addSubview(view)
            move(view, to: .up)
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        view.addGestureRecognizer(pan)
        
        animateMove(view, to: .down)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + configuration.intervalTime) {
            guard
                self.hidingViews.contains(view) == false,
                view.superview != nil else {
                return
            }
            self.hideUp(view)
        }
    }
    
    public func hide() {
        guard let notificationView = currentNotificationView else {
            return
        }
        hideUp(notificationView)
    }
    
    
    // MARK: - Private Methods

    private func addNotificationView(_ notificationView: UIView) {
        if let currentView = currentNotificationView {
            hideUp(currentView)
        }
        currentNotificationView = notificationView
        addSubview(notificationView)
        move(notificationView, to: .up)
    }
    
    private func updateWindow() {
        window.isHidden = view.subviews.isEmpty
    }
    
    private func addSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        
        NSLayoutConstraint.activate([
            subview.rightAnchor.constraint(equalTo: view.rightAnchor),
            subview.leftAnchor.constraint(equalTo: view.leftAnchor),
            subview.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        view.layoutIfNeeded()
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
            withDuration: configuration.animationDuration,
            delay: 0,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: { self.move(view, to: direction) },
            completion: completion)
    }
    
    private func hideUp(_ view: UIView) {
        hidingViews.append(view)
        if currentNotificationView === view {
            currentNotificationView = nil
        }
        animateMove(view, to: .up) { _ in
            if let index = self.hidingViews.firstIndex(of: view) {
                self.hidingViews.remove(at: index)
            }
            view.removeFromSuperview()
            self.updateWindow()
        }
    }
    
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
    
    
    // MARK: - UIViewController

    // Используем контроллер, чтобы установить цвет.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return NotificationWindowController.shared.configuration.statusBarLight
    }
}
