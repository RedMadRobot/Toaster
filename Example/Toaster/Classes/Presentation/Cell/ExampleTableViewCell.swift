//
//  ExampleTableViewCell.swift
//  Toaster_Example
//
//  Created by Andrei Nedov on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

final class ExampleTableViewCell: UITableViewCell {
    
    
    // MARK: - Constants
    
    static let reuseIdentifier = "ExampleTableViewCell"
    
    
    // MARK: - Initializers

    private let actionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(actionLabel)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Methods
    
    func configure(with text: String) {
        actionLabel.text = text
    }
    
}


extension ExampleTableViewCell {
    
    
    // MARK: - Private Methods
    
    private func layout() {
        actionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        actionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        actionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        actionLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
}
