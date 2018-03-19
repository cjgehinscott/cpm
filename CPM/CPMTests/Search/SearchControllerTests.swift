//
//  SearchControllerTests.swift
//  CPMTests
//
//  Created by CJ Gehin-Scott on 3/18/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import XCTest
@testable import CPM

class SearchControllerTests: XCTestCase {
    
    var controller: CPSearchController?
    var repositories: [CPRepository]?
    
    override func setUp() {
        super.setUp()
        do {
            guard let data = TestDataHelper.loadDataFromFile(fileName: "RepositoriesTest") else {
                XCTFail("Failed to load repository data from file")
                return
            }
            let repositoriesJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any?]]
            repositories = CPRepository.arrayOfRepositoriesWith(array: repositoriesJSON)
        } catch{
            XCTFail(error.localizedDescription)
        }
        
        controller = CPSearchController(view: nil)
    }
    
    override func tearDown() {
        controller = nil
        repositories = nil
        super.tearDown()
    }
    
    func testRepositoriesByLanguage(){
        if repositories?.count ?? 0 > 0{
            controller?.repositories = repositories
            XCTAssertEqual(controller?.repositoriesByLanguageSortedByStars(language: "Java")?.count, 5, "repository count should be 5")
            if let repos = controller?.repositoriesByLanguageSortedByStars(language: "Java"){
                for i in 0..<repos.count{
                    if i != repos.count-1{
                        XCTAssertGreaterThanOrEqual(repos[i].stars ?? 0, repos[i+1].stars ?? 0, "Repos are out of order")
                    }
                }
            }
        }else{
            XCTFail("Repository count is 0")
        }
    }
    
    func testLanguagesPerformance(){
        controller?.repositories = repositories
        self.measure {
            for _ in 1...1000{
                let _ = controller?.languages
            }
        }
    }
}
