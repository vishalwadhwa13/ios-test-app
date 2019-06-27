//
//  TableViewCell.swift
//  ios-test-app
//
//  Created by Zomato on 26/06/19.
//  Copyright © 2019 Zomato. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    let leftImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createView() {
        let padConst: CGFloat = 10
        
        contentView.addSubview(leftImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitle)
        
        leftImageView.layer.cornerRadius = 20
        leftImageView.layer.borderColor = UIColor.black.cgColor
        leftImageView.layer.borderWidth = 1.2
        leftImageView.layer.masksToBounds = true
        
        leftImageView.set(.leading(contentView, padConst),
                          .sameTopBottom(contentView, padConst),
                          .width(60),
                          .height(60))
        
        titleLabel.set(.trailing(contentView, padConst),
                       .after(leftImageView, padConst),
                       .top(leftImageView))
        
        subtitle.set(.trailing(contentView, padConst),
                     .below(titleLabel, padConst),
                     .after(leftImageView, padConst))
        
        titleLabel.text = "Title"
        subtitle.text = "Subtitle"
        leftImageView.backgroundColor = .orange
    }
    
    public func setData(titleText: String, subtitleText: String, image: UIImage) {
        titleLabel.text = titleText
        subtitle.text = subtitleText
        leftImageView.image = image
    }
    
    public func setData(cellData: CellData) {
        titleLabel.text = cellData.title
        subtitle.text = cellData.subtitle
        leftImageView.image = cellData.image
    }

}
