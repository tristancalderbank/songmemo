//
//  ViewControllerTableViewTextCell.swift
//  songmemo
//
//  Created by testuser1 on 2018-12-12.
//  Copyright © 2018 songmemo. All rights reserved.
//

import UIKit

class ViewControllerTableViewTextCell: UITableViewCell {

    @IBOutlet weak var textCellTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
