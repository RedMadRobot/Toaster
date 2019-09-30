//
//  SectionType.swift
//  Toaster_Example
//
//  Created by Andrei Nedov on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

enum SectionType: Int, CaseIterable {
    case settings
    case actions
    
    var title: String {
        switch self {
        case .settings:
            return "Настройки"
        case .actions:
            return "Примеры"
        }
    }
}
