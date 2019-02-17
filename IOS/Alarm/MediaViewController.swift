//
//  MusicViewController.swift
//  Alarm-ios-swift
//
//  Created by longyutao on 16/2/3.
//  Copyright (c) 2016年 LongGames. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController  {
    
    @IBOutlet var tableView: UITableView!
    
    fileprivate let numberOfRingtones = 3
    var mediaLabel: String!
    var mediaID: String!
    var stations = [RadioStation]() {
        didSet {
            guard stations != oldValue else { return }
            // stationsDidUpdate()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "NothingFoundCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "NothingFound")
        loadStationsFromJSON()
    }

    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Id.soundUnwindIdentifier, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let header = view as? UITableViewHeaderFooterView else { return }
//        header.textLabel?.textColor =  UIColor.gray
//        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 10)
//        header.textLabel?.frame = header.frame
//        header.textLabel?.textAlignment = .left
//    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // Return the number of sections.
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // Return the number of rows in the section.
//        return numberOfRingtones
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Sound"
//    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50.0
//    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: Id.musicIdentifier)
//        if(cell == nil) {
//            cell = UITableViewCell(
//                style: UITableViewCellStyle.default, reuseIdentifier: Id.musicIdentifier)
//        }
//        if indexPath.row == 0 {
//            cell!.textLabel!.text = "bell"
//        }
//        else if indexPath.row == 1 {
//            cell!.textLabel!.text = "tickle"
//        }
//        else if indexPath.row == 2 {
//            cell!.textLabel!.text = "Sing"
//        }
//
//        if cell!.textLabel!.text == mediaLabel {
//            cell!.accessoryType = UITableViewCellAccessoryType.checkmark
//        }
//        return cell!
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = UITableViewCellAccessoryType.checkmark
//        mediaLabel = cell?.textLabel?.text!
//        cell?.setSelected(true, animated: true)
//        cell?.setSelected(false, animated: true)
//        let cells = tableView.visibleCells
//        for c in cells {
//            let section = tableView.indexPath(for: c)?.section
//            if (section == indexPath.section && c != cell) {
//                c.accessoryType = UITableViewCellAccessoryType.none
//            }
//        }
//    }
    
    //*****************************************************************
    // MARK: - Load Station Data
    //*****************************************************************

    func loadStationsFromJSON() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DataManager.getStationDataWithSuccess() { (data) in
            defer {
                DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
            }

            guard let data = data, let jsonDictionary = try? JSONDecoder().decode([String: [RadioStation]].self, from: data), let stationsArray = jsonDictionary["station"] else {
                return
            }

            self.stations = stationsArray
        }
    }
    
    private func stationsDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//*****************************************************************
// MARK: - TableViewDataSource
//*****************************************************************

extension MediaViewController: UITableViewDataSource {
    
    @objc(tableView:heightForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.isEmpty ? 1 : stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if stations.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Not Found.", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
            
            cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.2)
            let station = stations[indexPath.row]
            cell.configureStationCell(station: station)
            
            return cell
        }
    }
}

//*****************************************************************
// MARK: - TableViewDelegate
//*****************************************************************

extension MediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(stations[indexPath.row])
    }
}
