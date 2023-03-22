//
//  ViewController.swift
//  ExampleAppsFlyer
//
//  Created by Tamerlan Imanov on 20.03.2023.
//

import UIKit
import AppsFlyerLib

extension Notification.Name {
    static let didReceiveDeepLink = Notification.Name("didReceiveDeepLink")
    static let processing = Notification.Name("processing")
}

final class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var label: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .didReceiveDeepLink, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleProcessing), name: .processing, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func handleProcessing(notification: NSNotification) {
        label.text = "Processing"
        label.textColor = .yellow
    }

    @objc
    func handleNotification(notification: NSNotification) {
        let result = notification.userInfo!["info"] as! DeepLinkResult
        switch result.status {
        case .found:
            let deepLinkValue: String? = result.deepLink?.deeplinkValue
            let deepLinkSubValue: String? = result.deepLink?.clickEvent["deep_link_sub1"] as? String
            let deepLinkRawValue: String! = (deepLinkSubValue != nil) ? deepLinkSubValue : deepLinkValue
            label.text = "Result: \(deepLinkRawValue!)"
            label.textColor = .green
        case .notFound:
            label.text = "Result: not found"
            label.textColor = .red
        case .failure:
            label.text = "Result: failure"
            label.textColor = .red
        }
        
        
    }
}
