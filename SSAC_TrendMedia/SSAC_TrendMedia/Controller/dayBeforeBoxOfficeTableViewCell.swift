//
//  dayBeforeBoxOfficeTableViewCell.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/26.
//

import UIKit

class dayBeforeBoxOfficeTableViewCell: UITableViewCell {
    
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    static let identifier = "dayBeforeBoxOfficeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
