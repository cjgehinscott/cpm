//
//  CPOwner.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPOwner: NSObject {

    var login: String?
    var id: Int?
    var type: String?
    
    convenience init?(dict: [String:Any?]?) {
        self.init()
        self.login = dict?["login"] as? String
        self.id = dict?["id"] as? Int
        self.type = dict?["type"] as? String
    }
}
