//
//  ItemTableViewCell.swift
//  CoreDataDemo
//
//  Created by Victor Idongesit on 03/03/2018.
//  Copyright © 2018 Victor Idongesit. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
