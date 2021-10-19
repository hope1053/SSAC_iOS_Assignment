//
//  BookCollectionViewController.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/19.
//

import UIKit

class BookCollectionViewController: UIViewController {
    
    let bookInformation = TvShowInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self

        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        updateLayout()
    }
    
    func updateLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 5)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing * 2, bottom: spacing, right: spacing * 2)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        bookCollectionView.collectionViewLayout = layout
    }
    
    @IBOutlet var bookCollectionView: UICollectionView!
}

extension BookCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInformation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let bookInfo = bookInformation.tvShow[indexPath.item]
        let colorList = [#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.7724966407, green: 0.8129963875, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.7804275155, blue: 0.9509593844, alpha: 1)]
        cell.bookImageView.image = UIImage(named: bookInfo.title)
        cell.bookRateLabel.text = "\(bookInfo.rate)"
        cell.bookTitleLabel.text = bookInfo.title
        cell.backgroundColor = colorList.randomElement()
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
}
