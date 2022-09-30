//
//  PlaceTableViewCell.swift
//  Tourist
//
//  Created by ccc on 9/28/22.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
