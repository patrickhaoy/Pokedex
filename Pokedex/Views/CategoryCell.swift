//
//  CategoryCell.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/17/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var bugButton: UIButton!
    @IBOutlet weak var grassButton: UIButton!
    @IBOutlet weak var darkButton: UIButton!
    @IBOutlet weak var groundButton: UIButton!
    @IBOutlet weak var dragonButton: UIButton!
    @IBOutlet weak var iceButton: UIButton!
    @IBOutlet weak var electricButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var fairyButton: UIButton!
    @IBOutlet weak var poisonButton: UIButton!
    @IBOutlet weak var fightingButton: UIButton!
    @IBOutlet weak var psychicButton: UIButton!
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var flyingButton: UIButton!
    @IBOutlet weak var steelButton: UIButton!
    @IBOutlet weak var ghostButton: UIButton!
    @IBOutlet weak var waterButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
