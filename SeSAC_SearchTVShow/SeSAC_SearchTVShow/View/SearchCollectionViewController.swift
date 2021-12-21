//
//  SearchCollectionViewController.swift
//  SeSAC_SearchTVShow
//
//  Created by 최혜린 on 2021/12/21.
//

import UIKit

import SnapKit

class SearchCollectionViewController: UIViewController {
    
    var tvShow: TVShow?
    
    let searchShowAPI = searchAPI()
    
    var currentPage = 1
    
    // CollectionView는 UICollectionView()와 같이 초기화를 진행하면 에러가 난다.
    // customCollectionView = CustomCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init()) 이런식으로 초기화시켜줘야함!
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        flowLayout.itemSize = CGSize(width: width / 3, height: width / 3 * 1.25)
        flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색"
        view.backgroundColor = .white
        
        addSearchController()
        addCollectionView()
        
        searchShowAPI.requestTVShow(keyword: "뱀파이어", page: currentPage) { result in
            print(result)
        }
    }
    
    func addSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "티비 쇼를 검색해보세요!"
        searchController.searchResultsUpdater = self

        self.navigationItem.searchController = searchController
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue

        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SearchCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("yes")
    }
}

extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }

    
}
