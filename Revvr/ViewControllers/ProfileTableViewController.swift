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
    let keys = ["firstname", "lastname", "dob", "gender", "religion", "politics", "education", "profession", "interests", "city", "administrative_area", "country"]
    var userDict = [
        "firstname": AppUserProperty(type: .textfield, name: "First Name"),
        "lastname": AppUserProperty(type: .textfield, name: "Last Name"),
        "dob": AppUserProperty(type: .date, name: "Date of Birth"),
        "gender": AppUserProperty(type: .textfield, name: "Gender"),
        "religion": AppUserProperty(type: .textfield, name: "Religion"),
        "politics": AppUserProperty(type: .textfield, name: "Politics"),
        "education": AppUserProperty(type: .textfield, name: "Education"),
        "profession": AppUserProperty(type: .textfield, name: "Profession"),
        "interests": AppUserProperty(type: .textview, name: "Interests"),
        "city": AppUserProperty(type: .textfield, name: "City"),
        "administrative_area": AppUserProperty(type: .textfield, name: "State"),
        "country": AppUserProperty(type: .textfield, name: "Country")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = AppUserAPIService.shared.currentUser {
            userDict["firstname"]?.value = currentUser.firstName
            userDict["lastname"]?.value = currentUser.lastName
            userDict["dob"]?.value = currentUser.dob
            userDict["gender"]?.value = currentUser.gender
            userDict["religion"]?.value = currentUser.religion
            userDict["politics"]?.value = currentUser.politics
            userDict["education"]?.value = currentUser.education
            userDict["profession"]?.value = currentUser.profession
            userDict["interests"]?.value = currentUser.interests
            userDict["city"]?.value = currentUser.city
            userDict["administrative_area"]?.value = currentUser.administrativeArea
            userDict["country"]?.value = currentUser.country
        }

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
        return keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let property = userDict[keys[indexPath.row]] else { return UITableViewCell(style: .default, reuseIdentifier: "")}
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
        
        if let value = property.value {
            switch property.type {
                case .textview:
                    let textView = cell.viewWithTag(20) as! UITextView
                    if let text = value as? String {
                        textView.text = text
                    }
                case .textfield:
                    let textfield = cell.viewWithTag(10) as! UITextField
                    if let text = value as? String {
                        textfield.text = text
                    }
                case .date:
                    let datePicker = cell.viewWithTag(20) as! UIDatePicker
                    if let date = value as? Date {
                        datePicker.date = date
                    }
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let property = userDict[keys[indexPath.row]] else { return 0 }
        
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
        guard let currentUser = AppUserAPIService.shared.currentUser,
            let firstName = getValue(forRow: 0) as? String,
            let lastName = getValue(forRow: 1) as? String,
            let city = getValue(forRow: 9) as? String,
            let administrativeArea = getValue(forRow: 0) as? String,
            let country = getValue(forRow: 11) as? String,
            let dob = getValue(forRow: 2) as? Date,
            let gender = getValue(forRow: 3) as? String,
            let religion = getValue(forRow: 4) as? String,
            let politics = getValue(forRow: 5) as? String,
            let education = getValue(forRow: 6) as? String,
            let profession = getValue(forRow: 7) as? String,
            let interests = getValue(forRow: 8) as? String
        else {
            return
        }
        
        let user = AppUser(firstName: firstName,
                           lastName: lastName,
                           handle: currentUser.handle,
                           email: currentUser.email,
                           password: currentUser.password,
                           city: city,
                           administrativeArea: administrativeArea,
                           country: country,
                           dob: dob,
                           gender: gender,
                           religion: religion,
                           politics: politics,
                           education: education,
                           profession: profession,
                           interests: interests,
                           content: currentUser.content,
                           settings: currentUser.settings)
        
        AppUserAPIService.shared.update(id: currentUser.id, user: user).then { user in
            
        }
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getValue(forRow row: Int) -> Any? {
        guard let property = userDict[keys[row]] else { return nil }
        let cell = self.tableView(self.tableView, cellForRowAt: IndexPath(row: row, section: 0))
        
        switch property.type {
            case .textview:
                let textView = cell.viewWithTag(20) as! UITextView
                return textView.text
            case .textfield:
                let textfield = cell.viewWithTag(10) as! UITextField
                return textfield.text
            case .date:
                let datePicker = cell.viewWithTag(20) as! UIDatePicker
                return datePicker.date
        }
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
