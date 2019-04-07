//
//  ReviewStatsTableViewCell.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-23.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

class ReviewStatsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ReviewStatsTableViewCellIdentifier"
    
    @IBOutlet weak var statsLabel: UILabel!
    
    func setStats(review: Review) {
        ReviewAPIService.shared.stats(id: review.id).then { stats in
            self.statsLabel.text = "\(stats.replyCount) replies | \(stats.agreeCount) agrees | \(stats.disagreeCount) disagrees"
        }
    }
}
