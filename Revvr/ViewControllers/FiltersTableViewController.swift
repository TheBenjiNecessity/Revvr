//
//  FiltersTableViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2019-04-14.
//  Copyright © 2019 Benjamin Wishart. All rights reserved.
//

import UIKit

struct row {
    var identifier = ""
    var leftLabel = ""
    var rightLabel = ""
    var description = ""
    var titles: [String] = []
    var cell: FilterTableViewCell?
}

class FiltersTableViewController: UITableViewController {
    let locations = ["North America", "South America", "Europe", "Asia", "Africa", "Austalia"]
    var preferences = AppUserPreferences(ageRange: nil,
                                         politicalAffiliation: nil,
                                         politicalOpinion: nil,
                                         location: nil,
                                         religiosity: nil,
                                         personality: nil)
    var rows = [
        row(identifier: RangeSliderTableViewCell.reuseIdentifier, leftLabel: "", rightLabel: "", description: "Age Range", titles: [], cell: nil),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Liberal", rightLabel: "Conservative", description: "Political Affiliation", titles: [], cell: nil),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Socialist", rightLabel: "Libertarian", description: "Political Opinion", titles: [], cell: nil),
        row(identifier: RadioPickerTableViewCell.reuseIdentifier, leftLabel: "", rightLabel: "", description: "Location", titles: ["North America", "South America", "Europe", "Asia", "Africa", "Austalia"], cell: nil),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Religious", rightLabel: "Non-Religious", description: "Religiosity", titles: [], cell: nil),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Introverted", rightLabel: "Extroverted", description: "Personality", titles: [], cell: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = AppUserAPIService.shared.currentUser {
            AppUserAPIService.shared.getPreferences(id: currentUser.id).then { preferences in
                self.preferences = preferences
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = rows[indexPath.row]
        
        switch row.identifier {
            case RangeSliderTableViewCell.reuseIdentifier:
                return 167
            case SliderTableViewCell.reuseIdentifier:
                return 103
            case RadioPickerTableViewCell.reuseIdentifier:
                return CGFloat(row.titles.count * 39) + 8
            default:
                return 100
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let value = getValue(forRow: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        
        switch row.identifier {
            case RangeSliderTableViewCell.reuseIdentifier:
                let rangeSliderTableViewCell = cell as! RangeSliderTableViewCell
                
                var leftValue: Int?
                var rightValue: Int?
                if let valueString = value as? String {
                    let values = valueString.components(separatedBy: ",")
                    leftValue = Int(values[0])
                    rightValue = Int(values[1])
                }
                
                rangeSliderTableViewCell.setTitleLabelText(text: row.description)
                rangeSliderTableViewCell.setValues(minValue: 0, maxValue: 120, minimumDistance: 1, lValue: leftValue, rValue: rightValue)
            case SliderTableViewCell.reuseIdentifier:
                let sliderTableViewCell = cell as! SliderTableViewCell
                
                sliderTableViewCell.setLabels(leftLabel: row.leftLabel, rightLabel: row.rightLabel, description: row.description)
                sliderTableViewCell.initSlider(minValue: 0, maxValue: 100, currentValue: value as? Float)
            case RadioPickerTableViewCell.reuseIdentifier:
                let radioPickerTableViewCell = cell as! RadioPickerTableViewCell
                
                var values: [String: Bool] = [:]
                if let valueString = value as? String {
                    let dict = valueString.dictionary()
                    values = Dictionary(uniqueKeysWithValues: dict.map { key, value in (key, value == "true") })
                }
                
                let views = row.titles.map { radioPickerTableViewCell.createSwitchView(title: $0, value: values[$0] ?? false) }
                
                radioPickerTableViewCell.addSubviews(subviews: views)
            default: break
        }
        
        rows[indexPath.row].cell = cell as? FilterTableViewCell
        return cell
    }
    
    func getValue(forRow row: Int) -> Any? {
        switch row {
            case 0:
                return preferences.ageRange
            case 1:
                return preferences.politicalAffiliation
            case 2:
                return preferences.politicalOpinion
            case 3:
                return preferences.location
            case 4:
                return preferences.religiosity
            case 5:
                return preferences.personality
            default:
                return nil
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        if let currentUser = AppUserAPIService.shared.currentUser {
            let ageRng = rows[0].cell?.value as? String
            let polAff = rows[1].cell?.value as? Float
            let polOp = rows[2].cell?.value as? Float
            let location = rows[3].cell?.value as? String
            let religiosity = rows[4].cell?.value as? Float
            let personality = rows[5].cell?.value as? Float
            let preferences = AppUserPreferences(ageRange: ageRng,
                                                 politicalAffiliation: polAff,
                                                 politicalOpinion: polOp,
                                                 location: location,
                                                 religiosity: religiosity,
                                                 personality: personality)

            AppUserAPIService.shared.setPreferences(id: currentUser.id,
                                                    preferences: preferences).then { preferences in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
