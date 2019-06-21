//
//  DeliveryCell.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//

import UIKit

class DeliveryCell : UITableViewCell{
    
    let deliveryImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customCell()
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func customCell() {
        self.contentView.addSubview(deliveryImage)
        self.contentView.addSubview(descriptionLable)
        
        NSLayoutConstraint.activate([
            
            deliveryImage.heightAnchor.constraint(equalToConstant: 50),
            deliveryImage.widthAnchor.constraint(equalToConstant: 50),
            deliveryImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            deliveryImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            descriptionLable.heightAnchor.constraint(equalTo: deliveryImage.heightAnchor),
            descriptionLable.leadingAnchor.constraint(equalTo: deliveryImage.trailingAnchor, constant: 8),
            descriptionLable.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            descriptionLable.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            ])
        
    }
}
