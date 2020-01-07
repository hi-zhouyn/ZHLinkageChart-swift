//
//  ZHTitleCollectionViewCell.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/26.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit

class ZHTitleCollectionViewCell: UICollectionViewCell {
    
    var showBorder = false {
        didSet {
            if showBorder && contentView.layer.cornerRadius == 0.0 {
                contentView.backgroundColor = UIColor.groupTableViewBackground
                contentView.layer.masksToBounds = true
                contentView.layer.cornerRadius = 2
                contentView.layer.borderColor = UIColor.lightGray.cgColor
                contentView.layer.borderWidth = 0.5
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init(frame: self.bounds)
        titleLabel.textColor = UIColor.darkText
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(titleLabel)
        return titleLabel
    }()
    
    
}
