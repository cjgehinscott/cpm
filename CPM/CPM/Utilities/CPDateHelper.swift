//
//  CPDateHelper.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/11/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPDateHelper: NSObject {

    static func dateFromString(dateString:String?)->Date?{
        guard let date = dateString else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: date)
    }
    
    static func tableViewCellStringForDate(date: Date?)->String?{
        guard let date = date else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
