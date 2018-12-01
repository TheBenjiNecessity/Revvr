//
//  SettingsTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-24.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    var settings = Setting(title: "", groups: [])
    
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
        } else {
            cell.setItem(item: row)
        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return getRow(forIndexPath: indexPath).itemType == .setting
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = getRow(forIndexPath: indexPath)
        
        if let setting = row.setting {
            let newSettingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
            newSettingsViewController.settings = setting
            self.navigationController?.pushViewController(newSettingsViewController, animated: true)
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
        }
    }
    
    func getRow(forIndexPath indexPath: IndexPath) -> Item {
        let section = settings.groups[indexPath.section]
        return section.items[indexPath.row]
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
