//
//  SwitchTableViewCell.swift
//  Toaster_Example
//
//  Created by Andrei Nedov on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol SettingSwitchTableViewCellDelegate: NSObjectProtocol {
    func settingSwitchTableViewCell(_ cell: SettingSwitchTableViewCell, switchUpdated isOn: Bool)
}

final class SettingSwitchTableViewCell: UITableViewCell {
    
    
    // MARK: - Constants
    
    static let reuseIdentifier = "SettingSwitchTableViewCell"
    
    
    // MARK: - Public Properties
    
    /// Для вычисления ячейки в методе делегата
    var indexPath: IndexPath?
    
    /// Внешнее свойство для положения свитча
    var isSwitchOn: Bool? = nil {
        didSet {
            guard let isSwitchOn = isSwitchOn else {return}
            settingSwitch.isOn = isSwitchOn
        }
    }
    
    /// Для уведомления об изменении положения свитча
    weak var delegate: SettingSwitchTableViewCellDelegate?
    

    // MARK: - Private Properties

    private let settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    private let settingSwitch: UISwitch = {
        let settingSwitch = UISwitch()
        settingSwitch.translatesAutoresizingMaskIntoConstraints = false
        return settingSwitch
    }()
    
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setProperties()
        setSelector()
        contentView.addSubview(settingLabel)
        contentView.addSubview(settingSwitch)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods

    func configure(with text: String) {
        settingLabel.text = text
    }
    
    
    // MARK: - Private methods
    
    private func setProperties() {
        selectionStyle = .none
    }
    
    private func setSelector() {
        settingSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    @objc private func switchValueChanged() {
        delegate?.settingSwitchTableViewCell(self, switchUpdated: settingSwitch.isOn)
    }
    
}


extension SettingSwitchTableViewCell {
    
    
    // MARK: - Private methods
    
    private func layout() {
        settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        settingSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        settingSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
}
