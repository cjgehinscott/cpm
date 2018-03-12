//
//  CPSearchVC.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPSearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var controller: CPSearchController?
    let headerNib = UINib(nibName: kSearchHeaderViewNib, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = CPSearchController(view: self)
        tableView?.delegate = controller
        tableView?.dataSource = controller
        tableView?.estimatedRowHeight = 50
        tableView?.estimatedSectionHeaderHeight = 50
        tableView?.register(headerNib, forHeaderFooterViewReuseIdentifier: kSearchHeaderViewReuseId)
        searchBar.delegate = controller
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {[weak self] in
            self?.tableView?.reloadData()
        }
    }

}
