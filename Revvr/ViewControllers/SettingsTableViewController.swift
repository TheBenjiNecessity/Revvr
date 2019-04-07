//
//  SettingsTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-24.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, SettingButtonTableViewCellDelegate {
    
    var settings = Setting(title: "", groups: [])
    var values: [String: Any?] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        self.title = settings.title
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settings.groups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.groups[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings.groups[section].title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: getReuseIdentifier(at: indexPath),
                                                 for: indexPath) as! SettingTableViewCell
        
        let section = settings.groups[indexPath.section]
        let row = section.items[indexPath.row]
        
        if row.itemType == .setting {
            cell.textLabel?.text = row.title
            if let value = row.value {
                cell.detailTextLabel?.text = values[value] as? String
            }
        } else {
            cell.setItem(item: row)
            
            if let buttonCell = cell as? SettingButtonTableViewCell {
                buttonCell.delegate = self
            }
        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = settings.groups[section]
        if section.title == "" {
            return 5
        } else {
            return 35
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return getRow(forIndexPath: indexPath).itemType == .setting
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = getRow(forIndexPath: indexPath)
        
        if let setting = row.setting {
            let newSettingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
            newSettingsViewController.settings = setting
            newSettingsViewController.values = values
            self.navigationController?.pushViewController(newSettingsViewController, animated: true)
        } else if let identifier = row.identifier {
            if let value = row.value {
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) {
                    if value == "#email#" {
                        (viewController as! UpdateEmailViewController).email = values[value] as! String
                    }
                    
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    // MARK: - Convenience methods
    
    func getReuseIdentifier(at indexPath: IndexPath) -> String {
        let row = getRow(forIndexPath: indexPath)
        
        switch row.itemType {
            case .info:
                return "SettingsDetailCellIdentifier"
            case .text:
                return "SettingsInputCellIdentifier"
            case .boolean:
                return "SettingsSwitchCellIdentifier"
            case .segment:
                return "SettingsSegmentCellIdentifier"
            case .setting:
                return "SettingsWithChildrenCellIdentifier"
            case .button:
                return "SettingsButtonCellIdentifier"
        }
    }
    
    func getRow(forIndexPath indexPath: IndexPath) -> Item {
        let section = settings.groups[indexPath.section]
        return section.items[indexPath.row]
    }
    
    func didPressSettingsButton(with item: Item?) {
        if let value = item?.value {
            switch value {
                case "logout":
                    SessionService.shared.doLogout()
                default:
                    return
            }
        }
    }
}
