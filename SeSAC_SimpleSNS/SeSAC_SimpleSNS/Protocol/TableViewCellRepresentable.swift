//
//  TableViewCellRepresentable.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import UIKit

protocol TableViewCellRepresentable {
    var numberOfRowsInSection: Int { get }
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

//extension TableViewCellRepresentable {
//    var numberOfSection: Int? { get }
//    var heightForRowAt: CGFloat? { get }
//}
