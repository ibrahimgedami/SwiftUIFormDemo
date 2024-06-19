//
//  UITableView+.swift
//  DropDownList
//
//  Created by Ibrahim Mo Gedami on 10/13/23.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

}

extension UITableView {
    
    func setupTableViewDesign() {
        self.tableFooterView = UIView()
        self.separatorInset = .zero
        self.contentInset = .zero
        self.separatorStyle = .none
    }
    
}
