//
//  CustomTableViewCell.swift
//  ios101-project5-tumblr
//
//  Created by Audrey Lam on 10/20/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        UITableView.automaticDimension
    }

}
