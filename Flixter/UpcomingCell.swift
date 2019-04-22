//
//  UpcomingCell.swift
//  Flixter
//
//  Created by Ryan M on 4/21/19.
//  Copyright © 2019 Ryan M. All rights reserved.
//

import UIKit

class UpcomingCell: UITableViewCell {

    @IBOutlet weak var posterVie: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
