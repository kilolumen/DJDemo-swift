//
//  ThemeProtocol.swift
//  ThemeManager
//
//  Created by Weico on 28/02/2017.
//  Copyright © 2017 kilolumen. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var backgroundColor: UIColor { get }
    var titleTextColor : UIColor { get }
    var detailTextColor: UIColor { get }

    
}

enum ThemeType {
    case red
    case blue

    var theme: ThemeProtocol {
        get {
            switch self {
            case .red:
                return RedTheme()
            case .blue:
                return BlueTheme()
            }
        }
    }
}
