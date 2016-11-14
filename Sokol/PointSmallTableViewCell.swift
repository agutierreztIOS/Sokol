//
//  PointSmallTableViewCell.swift
//  Sokol
//
//  Created by Andres Rene Gutierrez on 06/11/2016.
//  Copyright © 2016 Andres Rene Gutierrez. All rights reserved.
//

import UIKit

class PointSmallTableViewCell: UITableViewCell {

    @IBOutlet weak var pointNameText: UILabel!
    
    @IBOutlet weak var addressText: UILabel!
    
    @IBOutlet weak var checkpoint: UISwitch!
    
    @IBOutlet weak var showMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}