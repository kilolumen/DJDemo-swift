//
//  BaseViewController.swift
//  ThemeManager
//
//  Created by Weico on 28/02/2017.
//  Copyright © 2017 kilolumen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateThemeNotification(notification:)), name: ThemeNotificationName, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateThemeNotification(notification: Notification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
        self.view.backgroundColor = theme.backgroundColor
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: ThemeNotificationName, object: nil)
    }
}
