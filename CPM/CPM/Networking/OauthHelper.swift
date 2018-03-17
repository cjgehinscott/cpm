//
//  OauthHelper.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/17/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import Foundation

struct OauthHelper {
    
    static func parse(tokenString: String)->String?{
        for initialSplit in tokenString.split(separator: "&"){
            let tokenSplit = String(initialSplit).split(separator: "=")
            if (tokenSplit.count == 2){
                let key = String(tokenSplit[0]).lowercased() // access_token, scope, token_type
                let value = String(tokenSplit[1])
                switch key {
                case "access_token":
                    return value
                default:
                    return nil
                }
            }
        }
        return nil
    }
}
