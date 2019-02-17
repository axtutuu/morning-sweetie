//
//  RadioStation.swift
//  Alarm-ios-swift
//
//  Created by 川崎暑士 on 2019/02/17.
//  Copyright © 2019年 LongGames. All rights reserved.
//

import UIKit

// 構造体
struct RadioStation: Codable {
    var name: String
    var streamURL: String
    var imageURL: String
    var desc: String
    var longDesc: String
    
    init(name: String, streamURL: String, imageURL: String, desc: String, longDesc: String = "") {
        self.name = name
        self.streamURL = streamURL
        self.imageURL = imageURL
        self.desc = desc
        self.longDesc = longDesc
    }
}


// extension
// https://qiita.com/crea/items/4297bf60d222d661498f
extension RadioStation: Equatable {
    static func ==(lhs: RadioStation, rhs: RadioStation) -> Bool {
        return (lhs.name == rhs.name) && (lhs.streamURL == rhs.streamURL) && (lhs.imageURL == rhs.imageURL) && (lhs.desc == rhs.desc) && (lhs.longDesc == rhs.longDesc)
    }
}
