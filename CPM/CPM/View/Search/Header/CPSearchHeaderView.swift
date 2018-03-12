//
//  CPSearchHeaderView.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/11/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPSearchHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func setupWith(title:String?, count: Int?) {
        languageLabel.text = title
        countLabel.text = "\(count ?? 0)"
    }
    
    override func prepareForReuse() {
        languageLabel.text = nil
        countLabel.text = nil
    }

}
