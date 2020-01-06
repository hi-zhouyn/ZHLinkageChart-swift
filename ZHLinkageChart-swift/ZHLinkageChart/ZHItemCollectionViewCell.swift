//
//  ZHItemCollectionViewCell.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/26.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit

let KITEMHEIGHT: CGFloat = 39 //表格高度
let KITEMWIDTH: CGFloat = 55 //表格宽度
let KSPACE: CGFloat = 10 //表格间距
let KLINESPACE: CGFloat = 15 //表格边距
let KHEADHEIGHT: CGFloat = 25 //表格顶部head高度
let KSCREEN_WIDTH = (UIScreen.main.bounds.width)


class ZHItemCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init(frame: CGRect(x: 0, y: 15 - 7, width: self.frame.width, height: 12))
        titleLabel.textColor = UIColor.darkText
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(titleLabel)
        return titleLabel
    }()
    
    lazy var infoLabel: UILabel = {
        let infoLabel = UILabel.init(frame: CGRect(x: 0, y: self.titleLabel.frame.maxY + 2, width: self.frame.width, height: 12))
        infoLabel.textColor = UIColor.darkText
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(infoLabel)
        return infoLabel
    }()
    
    lazy var placeholderImageView: UIImageView = {
        let placeholderImageView = UIImageView.init(frame: self.bounds)
        placeholderImageView.image = UIImage.init(named: "nullplaceholder")
        placeholderImageView.contentMode = UIView.ContentMode.center
        self.addSubview(placeholderImageView)
        return placeholderImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 2
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 0.5
        self.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        self.updateDataWithTitle(title: "1", info: "2", tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
//        titleLabel.frame = CGRect(x: 0, y: 15 - 7, width: self.frame.width, height: 12)
//        infoLabel.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY + 2, width: self.frame.width, height: 12)
//        placeholderImageView.frame = self.bounds
    }
    
    @objc func updateDataWithTitle(title: String,info: String,tag: Int) -> Void {
        self.titleLabel.text = title
        self.infoLabel.text = info
        self.placeholderImageView.isHidden = !title.isEmpty
        if tag > 0 {
            self.contentView.backgroundColor = !title.isEmpty ? UIColor.green.withAlphaComponent(0.3) : UIColor.white
        } else {
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
}
