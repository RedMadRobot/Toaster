//
//  ViewController.swift
//  Toaster
//
//  Created by Andrey on 09/16/2019.
//  Copyright (c) 2019 Andrey. All rights reserved.
//

import UIKit
import Toaster

var isEdgeToEdgeEnabled = true

final class ViewController: UIViewController, NotificationPresentable {
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Public Properties

    /// Коллекция секций
    let sections = SectionType.allCases
    
    /// Коллекция ячеек со свитчами настроек
    let settings = SettingCellType.allCases
    
    /// Примеры реализации стандарных вариантов нотификаций
    let defaultNotifications = DefaultCellType.allCases
    
    /// Примеры реализации кастомных вариантов нотификаций
    let customNotifications = ExampleCellType.allCases
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SettingSwitchTableViewCell.self,
                           forCellReuseIdentifier: SettingSwitchTableViewCell.reuseIdentifier)
        tableView.register(ExampleTableViewCell.self,
                           forCellReuseIdentifier: ExampleTableViewCell.reuseIdentifier)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .settings:
            return settings.count
        case .defaultNotifications:
            return defaultNotifications.count
        case .customNotifications:
            return customNotifications.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .settings:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingSwitchTableViewCell.reuseIdentifier,
                for: indexPath) as! SettingSwitchTableViewCell
            
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configure(with: settings[indexPath.row].title)
            
            if let setting = SettingCellType(rawValue: indexPath.row) {
                switch setting {
                case .singleView:
                    cell.isSwitchOn =
                        NotificationWindowController.shared.configuration.isShowToastSingle
                case .statusBarStyle:
                    cell.isSwitchOn =
                        NotificationWindowController.shared.configuration.isStatusBarLight
                case .edgeToEdge:
                    cell.isSwitchOn = isEdgeToEdgeEnabled
                }
            }
            return cell
        case .defaultNotifications:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ExampleTableViewCell.reuseIdentifier,
                for: indexPath) as! ExampleTableViewCell
            
            cell.configure(with: defaultNotifications[indexPath.row].title)
            return cell
        case .customNotifications:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ExampleTableViewCell.reuseIdentifier,
                for: indexPath) as! ExampleTableViewCell
            
            cell.configure(with: customNotifications[indexPath.row].title)
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section] {
        case .defaultNotifications:
            guard let cellType = DefaultCellType(rawValue: indexPath.row)
                else { return }
            
            switch cellType {
            case .success:
                showFeedback(.successOperation)
            case .warning:
                showFeedback(.warningOperation)
            case .error:
                showFeedback(.somethingWentWrong)
            }
        case .customNotifications:
            guard let cellType = ExampleCellType(rawValue: indexPath.row)
                else { return }
            
            switch cellType {
            case .ok:
                showFeedback(.okOperation)
            case .bad:
                showFeedback(.badOperation)
            }
        default:
            break
        }
    }
}


// MARK: - SettingSwitchTableViewCellDelegate

extension ViewController: SettingSwitchTableViewCellDelegate {
    
    func settingSwitchTableViewCell(_ cell: SettingSwitchTableViewCell,
                                    switchUpdated isOn: Bool) {
        guard let indexPath = cell.indexPath else {return}
        guard let type = SettingCellType(rawValue: indexPath.row)
            else { return }
        
        switch type {
        case .singleView:
            NotificationWindowController.shared.configuration.isShowToastSingle = isOn
        case .statusBarStyle:
            NotificationWindowController.shared.configuration.isStatusBarLight = isOn
        case .edgeToEdge:
            isEdgeToEdgeEnabled = isOn
        }
    }
}

