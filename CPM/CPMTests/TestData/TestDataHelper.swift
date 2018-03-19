//
//  TestDataHelper.swift
//  CPMTests
//
//  Created by CJ Gehin-Scott on 3/18/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import Foundation

struct TestDataHelper {
    static func loadDataFromFile(fileName:String)->Data?{
        do{
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json"){
                let data = try Data(contentsOf: file)
                return data
            }else{
                print("No File")
            }
        }catch{
            print(error.localizedDescription)
            
        }
        return nil
    }
}

