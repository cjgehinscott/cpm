//
//  UIViewController+(Alert).swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: NSLocalizedString(kLocalizableOK, comment: kLocalizableOK), style: .default, handler: nil)
        alert.addAction(dismissAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func showUnauthorizedAlert(){
        let alert = UIAlertController(title: NSLocalizedString(kUnauthorizedTitle, comment: kUnauthorizedTitle), message: NSLocalizedString(kUnauthorizedMessage, comment: kUnauthorizedMessage), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString(kCancel, comment: kCancel), style: .destructive, handler: nil)
        let loginAction = UIAlertAction(title: NSLocalizedString(kLogin, comment: kLogin), style: .default) { action in
            APIManager.shared.launchOauthAuthorization()
        }
        alert.addAction(cancelAction)
        alert.addAction(loginAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func setNetworkActivityIndicator(_ isVisible:Bool){
        DispatchQueue.main.async {
             UIApplication.shared.isNetworkActivityIndicatorVisible = isVisible
        }
    }
    
}
