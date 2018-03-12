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
    
    func setNetworkActivityIndicator(_ isVisible:Bool){
        DispatchQueue.main.async {
             UIApplication.shared.isNetworkActivityIndicatorVisible = isVisible
        }
    }
    
}
