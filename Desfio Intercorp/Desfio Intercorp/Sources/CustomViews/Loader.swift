//
//  Loader.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/7/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import Foundation
import UIKit

class Loader {
    
    var activityIndicator: UIActivityIndicatorView
    var contentView: UIView
    
    
    static let sharedInstance: Loader = {
        
        let instance = Loader()
        return instance
    }()
    
    init() {
        contentView = UIView(frame: UIScreen.main.bounds)
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        self.activityIndicator.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        contentView.addSubview(self.activityIndicator)
    }
    
    func initLoader() {
        self.contentView = UIView(frame: UIScreen.main.bounds)
        self.contentView.backgroundColor = .clear
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        self.activityIndicator.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        self.contentView.addSubview(self.activityIndicator)
    }
    
    func start() {
        UIApplication.shared.keyWindow?.addSubview(self.contentView)
        self.activityIndicator.startAnimating()
    }
    
    func stop() {
        self.contentView.removeFromSuperview()
        self.activityIndicator.stopAnimating()
    }
    
}
