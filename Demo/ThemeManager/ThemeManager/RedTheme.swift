//
//  RedTheme.swift
//  ThemeManager
//
//  Created by Weico on 28/02/2017.
//  Copyright © 2017 kilolumen. All rights reserved.
//

import UIKit

class RedTheme: ThemeProtocol {
    var backgroundColor: UIColor {
        get {
            return UIColor.colorWithHex(0xD62608)
        }
    }
    var titleTextColor: UIColor {
        get {
            return UIColor.blue
        }
    }
    var detailTextColor: UIColor {
        get {
            return UIColor.gray
        }
    }

}
