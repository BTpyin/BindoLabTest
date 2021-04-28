//
//  PizzaTableViewCell.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 25/4/2021.
//

import UIKit

class PizzaTableViewCell: UITableViewCell {

    var rowNum = 0
    
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var pizzaEditButton: UIButton!
    @IBOutlet weak var pizzaDelegateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
