//
//  IconPageViewController.swift
//  Revvr
//
//  Created by Benjamin Wishart on 2018-11-19.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import UIKit

protocol IconSelectorDelegate: AnyObject {
    func iconSelector(_ selector: UICollectionViewController,
                      didSelectEmoji emoji: String)
}

class IconSelectorViewController: UICollectionViewController {
    var icons: [String] = []
    weak var delegate: IconSelectorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change pageLimit based on size class?
        // Set icons based on user preferences
        icons = ["100", "LoveIt", "HateIt", "Ecstatic", "Poop", "Sleeping", "Meh", "LikeIt", "DontLikeIt", "Indifferent", "Ok"]
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCollectionViewCell.reuseIdentifier, for: indexPath) as! IconCollectionViewCell
        
        cell.setIcon(icon: icons[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! IconCollectionViewCell
        let notification = Notification(name: IconCollectionViewCell.kClearCellsNotification, object: nil)
        NotificationCenter.default.post(notification)
        
        cell.setSelected()

        delegate?.iconSelector(self, didSelectEmoji: icons[indexPath.row])
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // This #hack prevents the scrollview from scrolling when tapped
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.size.width)
    }
}
