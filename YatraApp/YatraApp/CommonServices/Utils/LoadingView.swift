//
//  LoadingView.swift
//  SynApp
//
//  Created by Jatin Garg on 17/01/20.
//  Copyright © 2020 Sonam Gupta. All rights reserved.
//


import UIKit

class LoadingView: UIView {
    private var activityIndicator: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView(style: .whiteLarge)
        a.translatesAutoresizingMaskIntoConstraints = false
        a.startAnimating()
        return a
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        activityIndicator.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    public var color: UIColor = .white {
        didSet{
            activityIndicator.color = color
        }
    }
}
