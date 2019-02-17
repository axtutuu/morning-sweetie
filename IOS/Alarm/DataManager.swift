//
//  DataManager.swift
//  Alarm-ios-swift
//
//  Created by 川崎暑士 on 2019/02/16.
//  Copyright © 2019年 LongGames. All rights reserved.
//

import Foundation

import UIKit

struct DataManager {
    //*****************************************************************
    // Load local JSON Data
    //*****************************************************************

    static func getDataFromFileWithSuccess(success: (_ data: Data?) -> Void) {
        guard let filePathURL = Bundle.main.url(forResource: "stations", withExtension: "json") else {
            success(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: filePathURL, options: .uncached)
            success(data)
        } catch {
            fatalError()
        }
    }
    
    static func getStationDataWithSuccess(success: @escaping ((_ metaData: Data?) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            getDataFromFileWithSuccess() { data in
                success(data)
            }
        }
    }
}
