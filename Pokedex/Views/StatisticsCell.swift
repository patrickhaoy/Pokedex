//
//  StatisticsCell.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/19/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class StatisticsCell: UITableViewCell {

    @IBOutlet weak var statisticsName: UILabel!
    @IBOutlet weak var statistic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
