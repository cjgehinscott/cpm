//
//  APIManagerTests.swift
//  CPMTests
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import XCTest
@testable import CPM

class APIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchForRepositories() {
        let promise = expectation(description: "Request Finished")
        var repos: [CPRepository]?
        APIManager.shared.searchForReposWith(username: "dave") { (repositories, error) in
                repos = repositories
                promise.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { error in
            if error == nil{
                XCTAssertGreaterThan(repos?.count ?? 0, 0,"Repositories should be greater than 0")
            }
        }
    }
    
}
