//
//  SearchLocationCell.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 17/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

class SearchLocationCell: UITableViewCell {

    var titleLabel: UILabel = UILabel()
    var tempLabel: UILabel = UILabel()
    var iconImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(tempLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        //title label
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0-32.0-15.0).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not used")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
