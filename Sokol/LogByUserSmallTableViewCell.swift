//
//  LogByUserSmallTableViewCell.swift
//  Sokol
//
//  Created by Andres Rene Gutierrez on 06/11/2016.
//  Copyright © 2016 Andres Rene Gutierrez. All rights reserved.
//

import UIKit

class LogByUserSmallTableViewCell: UITableViewCell {

    @IBOutlet weak var showMore: UIButton!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}