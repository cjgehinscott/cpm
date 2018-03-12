//
//  CPRepository.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPRepository: NSObject {

    var id: Int?
    var name: String?
    var fullName: String?
    var language: String?
    var mDescription: String?
    var stars: Int?
    var updatedAt: Date?
    var owner: CPOwner?
    
    convenience init?(dict: [String:Any?]?) {
        self.init()
        self.id = dict?["id"] as? Int
        self.name = dict?["name"] as? String
        self.fullName = dict?["full_name"] as? String
        self.language = dict?["language"] as? String
        self.mDescription = dict?["description"] as? String
        self.stars = dict?["stargazers_count"] as? Int
        self.updatedAt = CPDateHelper.dateFromString(dateString: dict?["updated_at"] as? String) 
        self.owner = CPOwner(dict: dict?["owner"] as? [String:Any?])
    }
    
    static func arrayOfRepositoriesWith(array:[[String:Any?]?]?)->[CPRepository]?{
        var repositories:[CPRepository]?
        if let jsonArray = array{
            for repoJSON in jsonArray{
                if let repo = CPRepository(dict: repoJSON){
                    if repositories == nil{
                        repositories = [CPRepository]()
                    }
                    repositories?.append(repo)
                }
            }
        }
        return repositories
    }
    
}
