//
//  UITableView+Addition.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import UIKit

extension UITableView {

    func registerForCell<T>(_: T.Type) where T: UITableViewCell, T: NibLoadable {
        register(T.loadNib(), forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func registerForCell<T>(_: T.Type) where T: UITableViewCell {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueCellForIndexPath<T>(_ indexPath: IndexPath, identifier: String? = nil) -> T where T: UITableViewCell {
        let reuseIdentifier = identifier ?? T.defaultReuseIdentifier
        return dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}
