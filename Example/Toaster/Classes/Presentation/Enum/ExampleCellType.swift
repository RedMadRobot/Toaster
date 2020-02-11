//
//  ExampleCellType.swift
//  Toaster_Example
//
//  Created by Andrei Nedov on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

enum ExampleCellType: Int, CaseIterable {
    case ok
    case bad
    
    var title: String {
        switch self {
        case .ok:
            return "Успешная операция"
        case .bad:
            return "Ошибка выполнения"
        }
    }
    
}
