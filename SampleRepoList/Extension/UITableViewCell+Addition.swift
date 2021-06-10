//
//  UITableViewCell+Addition.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import UIKit

extension UITableViewCell {

    static var defaultHeight: CGFloat {
        return 60.0
    }

    class var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
