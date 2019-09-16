//
//  ViewController.swift
//  Toaster
//
//  Created by Andrey on 09/16/2019.
//  Copyright (c) 2019 Andrey. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, NotificationPresentable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationAppearance.shared.isShowToastSingle = false
        NotificationAppearance.shared.isBlurView = false
    }
    
    @IBAction func toastCall(_ sender: Any) {
        showFeedback(FeedbackNotification.somethingWentWrong)
    }
}

