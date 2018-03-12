//
//  CPSearchCell.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/11/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPRepositoryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupWith(name:String?, description:String?, stars: Int?, updatedDate: String?){
        nameLabel.text = name
        descriptionLabel.text = description
        starsLabel.text = "Stars: \(stars ?? 0)"
        updatedLabel.text = "Updated: \(updatedDate ?? "")"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        descriptionLabel.text = nil
        starsLabel.text = nil
        updatedLabel.text = nil
    }

}
