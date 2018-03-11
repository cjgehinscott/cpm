//
//  CPError.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPError: NSObject {

    var title: String?
    var message: String?
    var code: Int?
    
    convenience init?(title: String?, message: String?, code: Int?) {
        self.init()
        self.title = title
        self.message = message
        self.code = code
    }
}
