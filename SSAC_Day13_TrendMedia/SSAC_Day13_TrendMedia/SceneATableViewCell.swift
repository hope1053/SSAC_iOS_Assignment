//
//  SceneATableViewCell.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit

class SceneATableViewCell: UITableViewCell {

    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var starring: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet var mediaView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.updateImageUI()
        mediaView.updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
