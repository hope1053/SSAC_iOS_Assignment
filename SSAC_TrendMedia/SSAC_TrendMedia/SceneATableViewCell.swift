//
//  SceneATableViewCell.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit

class SceneATableViewCell: UITableViewCell {
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starring: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet var mediaView: UIView!
    
    var linkButtonTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.updateImageUI()
        mediaView.updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func linkButtonTapped(_ sender: UIButton) {
        linkButtonTapHandler?()
    }
}
