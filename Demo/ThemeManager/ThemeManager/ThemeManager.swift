//
//  ThemeManager.swift
//  ThemeManager
//
//  Created by Weico on 28/02/2017.
//  Copyright © 2017 kilolumen. All rights reserved.
//

import UIKit

let ThemeNotificationName = Notification.Name("ThemeNotificationKey")

class ThemeManager: NSObject {
    var theme: ThemeProtocol = RedTheme()

    static var manager: ThemeManager? = nil
    static func shareManager() -> ThemeManager {
        if manager == nil {
            manager = ThemeManager()
        }
        return manager!
    }

    static func switchTheme(type: ThemeType) {
        ThemeManager.shareManager().switchTheme(type: type)
    }

    static func updateTheme() {
        NotificationCenter.default.post(name: ThemeNotificationName, object: ThemeManager.shareManager().theme)
    }

    private override init() {}

    private func switchTheme(type: ThemeType) {
        self.theme = type.theme
        NotificationCenter.default.post(name: ThemeNotificationName, object: self.theme)
    }
}
