//
//  TableViewCell.swift
//  First My To Do List App
//
//  Created by 김태동 on 2017. 1. 11..
//  Copyright © 2017년 00aney. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var checkBox: UILabel!
    @IBOutlet weak var TodoItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
