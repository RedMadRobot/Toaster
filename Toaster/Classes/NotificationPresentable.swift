//
//  NotificationPresentable.swift
//  Toaster
//
//  Created by Andrei Nedov on 25/09/2019.
//

public protocol NotificationPresentable {
    
    func showFeedback(view: UIView)
}

/// Стандартная реализация протокола
public extension NotificationPresentable {

    func showFeedback(view: UIView) {
        NotificationWindowController.shared.show(view)
    }
}
