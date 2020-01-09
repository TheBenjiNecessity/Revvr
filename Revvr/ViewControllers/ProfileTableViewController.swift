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
    var view: UIView?
    
    init(type: viewType, name: String) {
        self.type = type
        self.name = name
        self.value = nil
    }
}

class ProfileTableViewController: UITableViewController {
    let keys = ["firstname", "lastname", "dateOfBirth", "gender", "religion", "politics", "education", "profession", "interests", "city", "administrative_area", "country"]
    var userDict = [
        "firstname": AppUserProperty(type: .textfield, name: "First Name"),
        "lastname": AppUserProperty(type: .textfield, name: "Last Name"),
        "dateOfBirth": AppUserProperty(type: .date, name: "Date of Birth"),
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
            userDict["dateOfBirth"]?.value = currentUser.dateOfBirth
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
        
        AppUserAPIService.shared.getApiUser().then { user in
            AppUserAPIService.shared.currentUser = user
            
            self.userDict["firstname"]?.value = user.firstName
            self.userDict["lastname"]?.value = user.lastName
            self.userDict["dateOfBirth"]?.value = user.dateOfBirth
            self.userDict["gender"]?.value = user.gender
            self.userDict["religion"]?.value = user.religion
            self.userDict["politics"]?.value = user.politics
            self.userDict["education"]?.value = user.education
            self.userDict["profession"]?.value = user.profession
            self.userDict["interests"]?.value = user.interests
            self.userDict["city"]?.value = user.city
            self.userDict["administrative_area"]?.value = user.administrativeArea
            self.userDict["country"]?.value = user.country
            
            self.tableView.reloadData()
        }
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
                    if let text = value as? String, let textView = cell.viewWithTag(20) as? UITextView {
                        textView.text = text
                        userDict[keys[indexPath.row]]?.view = textView
                    }
                case .textfield:
                    if let text = value as? String, let textfield = cell.viewWithTag(10) as? UITextField {
                        textfield.text = text
                        userDict[keys[indexPath.row]]?.view = textfield
                    }
                case .date:
                    if let date = value as? Date, let datePicker = cell.viewWithTag(30) as? UIDatePicker {
                        datePicker.date = date
                        userDict[keys[indexPath.row]]?.view = datePicker
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
            let administrativeArea = getValue(forRow: 10) as? String,
            let country = getValue(forRow: 11) as? String,
            let dateOfBirth = getValue(forRow: 2) as? Date,
            let gender = getValue(forRow: 3) as? String,
            let religion = getValue(forRow: 4) as? String,
            let politics = getValue(forRow: 5) as? String,
            let education = getValue(forRow: 6) as? String,
            let profession = getValue(forRow: 7) as? String,
            let interests = getValue(forRow: 8) as? String
        else {
            return
        }
        
        let user = AppUser(id: currentUser.id,
                           firstName: firstName,
                           lastName: lastName,
                           handle: currentUser.handle,
                           email: currentUser.email,
                           city: city,
                           administrativeArea: administrativeArea,
                           country: country,
                           dateOfBirth: dateOfBirth,
                           gender: gender,
                           religion: religion,
                           politics: politics,
                           education: education,
                           profession: profession,
                           interests: interests)
        
        AppUserAPIService.shared.update(id: currentUser.id, user: user).then { userResp in
            print(userResp)
            AppUserAPIService.shared.currentUser = userResp
        }.catch { error in
            print(error)
        }
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getValue(forRow row: Int) -> Any? {
        guard let property = userDict[keys[row]] else { return nil }
        
        switch property.type {
            case .textview:
                let textView = property.view as! UITextView
                return textView.text
            case .textfield:
                let textfield = property.view as! UITextField
                return textfield.text
            case .date:
                let datePicker = property.view as! UIDatePicker
                return datePicker.date
        }
    }
}
