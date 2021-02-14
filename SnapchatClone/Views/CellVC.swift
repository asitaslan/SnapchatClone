//
//  CellVC.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 14.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class CellVC: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
