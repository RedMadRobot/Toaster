//
//  FeedbackNotification.swift
//  toasterApp
//
//  Created by Andrei Nedov on 16/09/2019.
//  Copyright © 2019 Andrei Nedov. All rights reserved.
//

import UIKit
import Toaster

///Расширение для создания шаблонов нотификаций
extension FeedbackNotification{
    static let successOperation = FeedbackNotification(type: .success, text: "Операция выполнена успешно")
    static let warningOperation = FeedbackNotification(type: .warning, text: "Операция выполнена с ограничениями")
}
