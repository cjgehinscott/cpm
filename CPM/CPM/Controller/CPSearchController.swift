//
//  CPSearchController.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPSearchController: NSObject {
    
    private var repositories: [CPRepository]?
    private var view: CPSearchVC?
    
    convenience init?(view: CPSearchVC?) {
        self.init()
        self.view = view
    }
    
    func fetchRepositoriesFor(_ searchTerm: String?, _ completion:(()->())?){
        APIManager.shared.searchForReposWith(username: searchTerm) { [weak self] (repos, error) in
            if error != nil{
                self?.view?.showAlert(title: error?.title, message: error?.message)
            }else{
                print("Repositories fetched: \(repos ?? [CPRepository]())")
            }
        }
    }

}
