//
//  ViewController.swift
//  Toaster
//
//  Created by Andrey on 09/16/2019.
//  Copyright (c) 2019 Andrey. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, NotificationPresentable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let sections = SectionType.allCases
    let settings = SettingCellType.allCases
    let example = ExampleCellType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        configureTableView()
    }
    
    // MARK: - Private methods
    
    private func configureAppearance() {
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(SettingSwitchTableViewCell.self, forCellReuseIdentifier: SettingSwitchTableViewCell.reuseIdentifier)
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: ExampleTableViewCell.reuseIdentifier)

    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .settings:
            return settings.count
        case .actions:
            return example.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .settings:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchTableViewCell.reuseIdentifier, for: indexPath) as! SettingSwitchTableViewCell
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configure(with: settings[indexPath.row].title)
            
            if let setting = SettingCellType(rawValue: indexPath.row) {
                switch setting {
                case .blurView:
                    cell.isSwitchOn = NotificationAppearance.shared.isBlurView
                case .singleView:
                    cell.isSwitchOn = NotificationAppearance.shared.isShowToastSingle
                }
            }
            return cell
        case .actions:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.reuseIdentifier, for: indexPath) as! ExampleTableViewCell
            cell.configure(with: example[indexPath.row].title)
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section] {
        case .actions:
            guard let cellType = ExampleCellType(rawValue: indexPath.row) else {return}
            
            switch cellType {
            case .success:
                showFeedback(.successOperation)
            case .warning:
                showFeedback(.warningOperation)
            case .error:
                showFeedback(.somethingWentWrong)
            }
        default:
            break
        }
    }
}

// MARK: - SettingSwitchTableViewCellDelegate

extension ViewController: SettingSwitchTableViewCellDelegate {
    
    func settingSwitchTableViewCell(_ cell: SettingSwitchTableViewCell, switchUpdated isOn: Bool) {
        guard let indexPath = cell.indexPath else {return}
        guard let type = SettingCellType(rawValue: indexPath.row) else {return}
        
        switch type {
        case .blurView:
            NotificationAppearance.shared.isBlurView = isOn
        case .singleView:
            NotificationAppearance.shared.isShowToastSingle = isOn
        }
    }
    
}

