//
//  UISearchBar+.swift
//  DropDownList
//
//  Created by Ibrahim Mo Gedami on 10/13/23.
//

import UIKit

extension UISearchBar {
    
    func addAttributesToSearchBar(size: CGFloat, color: UIColor) {
        if let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = color
            textFieldInsideSearchBar.font = UIFont.systemFont(ofSize: size)//UIFont(name: "Roboto-Regular", size: 15.0)
        }
        let searchBarAttributes: NSDictionary = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size),
                                                   NSAttributedString.Key.foregroundColor: color]//(name: "Roboto-Regular", size: 12.0)!
        UIBarButtonItem.appearance().setTitleTextAttributes(searchBarAttributes as? [NSAttributedString.Key : Any], for: .normal)
    }
    
}
