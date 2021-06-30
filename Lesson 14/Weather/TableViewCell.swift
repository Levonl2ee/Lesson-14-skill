//
//  TableViewCell.swift
//  lesson 12
//
//  Created by Левон Амбарцумян on 23.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var myTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
