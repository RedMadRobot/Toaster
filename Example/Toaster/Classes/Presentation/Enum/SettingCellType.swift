//
//  SettingCellType.swift
//  Toaster_Example
//
//  Created by Andrei Nedov on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

enum SettingCellType: Int, CaseIterable {
    case singleView
    case statusBarStyle
    case edgeToEdge
    
    var title: String {
        switch self {
        case .singleView:
            return "Одинарная нотификация"
        case .statusBarStyle:
            return "Белый статус бар"
        case .edgeToEdge:
            return "Edge-to-edge"
        }
        
    }
    
}
