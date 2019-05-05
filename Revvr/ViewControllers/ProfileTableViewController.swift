//
//  ProfileTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-05-04.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

struct AppUserProperty {
    enum viewType {
        case textfield
        case textview
        case date
    }
    
    var type: viewType
    var name = ""
    var value: Any?
    
    init(type: viewType, name: String) {
        self.type = type
        self.name = name
        self.value = nil
    }
}

class ProfileTableViewController: UITableViewController {
    var userDict = [
        AppUserProperty(type: .textfield, name: "First Name"),
        AppUserProperty(type: .textfield, name: "Last Name"),
        AppUserProperty(type: .date, name: "Date of Birth"),
        AppUserProperty(type: .textfield, name: "Gender"),
        AppUserProperty(type: .textfield, name: "Religion"),
        AppUserProperty(type: .textfield, name: "Politics"),
        AppUserProperty(type: .textfield, name: "Education"),
        AppUserProperty(type: .textfield, name: "Profession"),
        AppUserProperty(type: .textview, name: "Interests"),
        AppUserProperty(type: .textfield, name: "city"),
        AppUserProperty(type: .textfield, name: "administrative_area"),
        AppUserProperty(type: .textfield, name: "country")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDict.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let property = userDict[indexPath.row]
        var identifier = ""
        
        switch property.type {
            case .textview:
                identifier = "TextViewCellIdentifier"
            case .textfield:
                identifier = "TextFieldCellIdentifier"
            case .date:
                identifier = "DateViewCellIdentifier"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        let label = cell.viewWithTag(1) as! UILabel
        label.text = property.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let property = userDict[indexPath.row]
        
        switch property.type {
            case .textview:
                return 140
            case .textfield:
                return 73
            case .date:
                return 253
        }
    }

    @IBAction func didTapSaveButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
