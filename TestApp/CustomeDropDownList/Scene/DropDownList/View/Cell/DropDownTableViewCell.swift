//
//  DropDownTableViewCell.swift
//  DropDownList
//
//  Created by Ibrahim Mo Gedami on 10/13/23.
//

import UIKit

protocol DropDownTableViewCellProtocol {
    
    func setTitle(_ text: String?)
    
}

class DropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

extension DropDownTableViewCell: DropDownTableViewCellProtocol {
    
    func setTitle(_ text: String?) {
        titleLabel.text  = text
    }
    
}
