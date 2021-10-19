//
//  SummaryTableViewCell.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/19.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    static let identifier = "SummaryTableViewCell"
    
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var upDownButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
