//
//  MsgTableViewCell.swift
//  BLEChat2
//
//  Created by Guillaume Lagouy on 27/02/2020.
//  Copyright © 2020 Guillaume Lagouy. All rights reserved.
//

import UIKit

class MsgTableViewCell: UITableViewCell {

    @IBOutlet weak var msgTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        msgTextView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
