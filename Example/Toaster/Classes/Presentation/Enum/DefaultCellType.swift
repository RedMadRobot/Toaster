//
//  DefaultCellType.swift
//  Toaster_Example
//
//  Created by Andrei Nedov on 25/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

enum DefaultCellType: Int, CaseIterable {
    case success
    case warning
    case error
    
    var title: String {
        switch self {
        case .success:
            return "Успешное выполнение"
        case .warning:
            return "Предупреждение"
        case .error:
            return "Ошибка"
        }
    }
    
}

