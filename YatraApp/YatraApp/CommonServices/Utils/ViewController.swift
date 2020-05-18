//
//  ViewController.swift
//  SynApp
//
//  Created by Jatin Garg on 17/01/20.
//  Copyright © 2020 Sonam Gupta. All rights reserved.
//

import UIKit
import CoreLocation
enum AlertType: String {
    case failure = "Oops!"
    case success = "Success!"
    case info = "FYI"
}

enum LoaderPosition {
    case page, bottom, top
}
enum SearchType:Int {
    case LetsEat = 1
    case LetsDrink = 2
    case LetsConnect = 3
}
@objc protocol ViewControllerDelegate {
    @objc optional func didSearchItem(_ currentLocation: CLLocation?, location:CLLocation?, keyword: String?)
    @objc optional func didTapSearchDrink()
}
class ViewController: UIViewController {
    var shouldWhiteBackButton : Bool = false
    private var loaderMap: [LoaderPosition : LoadingView] = [:]
    private var gradientLayer: CAGradientLayer?
    
    public var searchedItemDelegate : ViewControllerDelegate?
    public var searchType : SearchType?
    
    private var loaderInstance: LoadingView {
        let l = LoadingView()
        l.color = UIColor.gray
        return l
    }
    private func constructAlertBox(OfType type: AlertType, andMessage message: String, handler: (() -> ())?) -> UIAlertController {
        let alertController = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Alright", style: .default) { _ in
            handler?()
        })
        return alertController
    }
    
    open func showPageLoader(atPosition position: LoaderPosition) {
        var targetLoader = loaderMap[position]
        
        guard targetLoader == nil else {
            return
        }
        
        targetLoader = loaderInstance
        targetLoader?.translatesAutoresizingMaskIntoConstraints = false
        targetLoader?.alpha = 0
        
        view.addSubview(targetLoader!)
        targetLoader?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        switch position {
        case .page:
            targetLoader?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
        case .bottom:
            if #available(iOS 11.0, *) {
                targetLoader?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            } else {
                targetLoader?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            }
        case .top:
            if #available(iOS 11.0, *) {
                targetLoader?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            } else {
                targetLoader?.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            }
        }
        
        UIView.animate(withDuration: 0.5) {
            targetLoader?.alpha = 1
        }
        
        loaderMap[position] = targetLoader
        
    }
    
    open func hidePageLoader(atPosition position: LoaderPosition) {
        guard let targetLoader = loaderMap[position] else {
            return
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            targetLoader.alpha = 0
        }) {_ in
            targetLoader.removeFromSuperview()
            self.loaderMap[position] = nil
        }
    }
    
open func showAlert(ofType type: AlertType,
                      andMessage message: String,
                      handler: (() -> ())? = nil) {
      view.endEditing(true)
      let alertBox = constructAlertBox(OfType: type,
                                       andMessage: message,
                                       handler: handler)
      present(alertBox, animated: true)
  }
    
    func hideBottomTabBar() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}


