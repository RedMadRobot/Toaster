//
//  SettingCellType.swift
//  Toaster_Example
//
//  Created by Andrei Nedov on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

enum SettingCellType: Int, CaseIterable {
    case blurView
    case singleView
    
    var title: String {
        switch self {
        case .blurView:
            return "Блюр вместо цветов"
        case .singleView:
            return "Одинарная нотификация"
        }
    }
}
