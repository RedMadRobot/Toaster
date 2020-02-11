//
//  FeedbackNotification.swift
//  toasterApp
//
//  Created by Andrei Nedov on 16/09/2019.
//  Copyright © 2019 Andrei Nedov. All rights reserved.
//

import UIKit
import Toaster

typealias NotificationPresentable = Toaster.NotificationPresentable

extension NotificationPresentable {
    func showFeedback(_ feedbackNotification: FeedbackNotification) {
        showFeedback(view: feedbackNotification.view)
    }
}

///Шаблоны нотификаций
enum FeedbackNotification {
    
    /// Цветные нотификаций
    case successOperation
    case warningOperation
    case somethingWentWrong
    
    /// Блюр нотификации
    case okOperation
    case badOperation

    var view: UIView {
        switch self {
        case .successOperation:
            return NotificationView(
                    type: .success,
                    color: .green,
                    text: "Операция выполнена успешно")
        case .warningOperation:
            return NotificationView(
                    type: .warning,
                    color: .orange,
                    text: "Операция выполнена с ограничениями")
        case .somethingWentWrong:
            return NotificationView(
                    type: .error,
                    color: .red,
                    text: "Что-то пошло не так")
        case .okOperation:
            return NotificationView(
                    type: .success,
                    color: nil,
                    text: "Ваш запрос успешно обработан")
        case .badOperation:
            return NotificationView(
                    type: .success,
                    color: nil,
                    text: "Невозможно выполнить данную операцию")
        }
    }
}
