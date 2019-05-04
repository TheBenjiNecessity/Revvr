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
}

class FiltersTableViewController: UITableViewController {
    
    let rows = [
        row(identifier: RangeSliderTableViewCell.reuseIdentifier, leftLabel: "", rightLabel: "", description: "Age Range", titles: []),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Liberal", rightLabel: "Conservative", description: "Political Affiliation", titles: []),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Socialist", rightLabel: "Libertarian", description: "Political Opinion", titles: []),
        row(identifier: RadioPickerTableViewCell.reuseIdentifier, leftLabel: "", rightLabel: "", description: "Location", titles: ["North America", "South America", "Europe", "Asia", "Africa", "Austalia"]),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Religious", rightLabel: "Non-Religious", description: "Religiosity", titles: []),
        row(identifier: SliderTableViewCell.reuseIdentifier, leftLabel: "Introverted", rightLabel: "Extroverted", description: "Personality", titles: [])
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
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        
        switch row.identifier {
            case RangeSliderTableViewCell.reuseIdentifier:
                let rangeSliderTableViewCell = cell as! RangeSliderTableViewCell
                
                rangeSliderTableViewCell.setTitleLabelText(text: row.description)
                rangeSliderTableViewCell.setValues(minValue: 0, maxValue: 120, minimumDistance: 1)
            case SliderTableViewCell.reuseIdentifier:
                let sliderTableViewCell = cell as! SliderTableViewCell
                
                sliderTableViewCell.setLabels(leftLabel: row.leftLabel, rightLabel: row.rightLabel, description: row.description)
                sliderTableViewCell.initSlider(minValue: 0, maxValue: 100, currentValue: 50)
            case RadioPickerTableViewCell.reuseIdentifier:
                let radioPickerTableViewCell = cell as! RadioPickerTableViewCell
                
                let views = row.titles.map { radioPickerTableViewCell.createSwitchView(title: $0) }
                
                radioPickerTableViewCell.addSubviews(subviews: views)
            default: break
        }
        
        return cell
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
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
