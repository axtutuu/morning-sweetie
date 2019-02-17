//
//  StationTableViewCell.swift
//  Alarm-ios-swift
//
//  Created by 川崎暑士 on 2019/02/17.
//  Copyright © 2019年 LongGames. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationDescLabel: UILabel!
    @IBOutlet weak var stationImageView: UIImageView!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 78/255, green: 82/255, blue: 93/255, alpha: 0.6)
        selectedBackgroundView = selectedView
        // stationNameLabel.text = station.name
        // stationDescLabel.text = station.desc
    }
    
    func configureStationCell(station: RadioStation) {
        stationNameLabel.text = station.name
        stationDescLabel.text = station.name
        
        let imageURL = station.imageURL as NSString
        
        if imageURL.contains("http") {
            
            if let url = URL(string: station.imageURL) {
                stationImageView.loadImageWithURL(url: url) { (image) in
                    // loaded
                }
            }
        } else if imageURL != "" {
            stationImageView.image = UIImage(named: imageURL as String)
        } else {
            stationImageView.image = UIImage(named: "stationImage")
        }
        
        // stationImageView.applyShadow()
     }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadTask?.cancel()
        downloadTask = nil
        stationNameLabel.text = nil
        stationDescLabel.text = nil
        stationImageView.image = nil
    }
}
