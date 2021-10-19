//
//  BookCollectionViewCell.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/19.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"

    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var bookRateLabel: UILabel!
    @IBOutlet var bookTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
