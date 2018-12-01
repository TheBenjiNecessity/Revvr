//
//  JSONModelObjectTests.swift
//  RevvrTests
//
//  Created by Benjamin Wishart on 2018-10-09.
//  Copyright © 2018 Benjamin Wishart. All rights reserved.
//

import XCTest
@testable import Revvr

class AppUserModelTests: XCTestCase {
    var json: Data!
    var dob: Date!
    var dateFormatter: DateFormatter!

    override func setUp() {
        let dateString = "1988-10-21T00:00:00"
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dob = dateFormatter.date(from: dateString)

        json = """
        {
            "firstName": "Benjamin",
            "lastName": "Wishart",
            "handle": "Benji",
            "email": "ben@ben.com",
            "city": "Saint John",
            "administrativeArea": "New Brunswick",
            "country": "Canada",
            "gender": "Male",
            "religion": "None",
            "password": "this shouldn't exist",
            "politics": "Conservative",
            "education": "Bachelors",
            "profession": "Comp. Sci.",
            "interests": "Something",
            "dob": "1988-10-21T00:00:00",
            "content": { },
            "settings": { }
        }
        """.data(using: .utf8)!
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testObjectLoadingFromJSON() {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let testUser = try decoder.decode(AppUser.self, from: json)
            
            XCTAssertTrue(testUser.firstName == "Benjamin")
            XCTAssertTrue(testUser.lastName == "Wishart")
            XCTAssertTrue(testUser.handle == "Benji")
            XCTAssertTrue(testUser.email == "ben@ben.com")
            XCTAssertTrue(testUser.city == "Saint John")
            XCTAssertTrue(testUser.administrativeArea == "New Brunswick")
            XCTAssertTrue(testUser.country == "Canada")
            XCTAssertTrue(testUser.gender == "Male")
            XCTAssertTrue(testUser.religion == "None")
            XCTAssertTrue(testUser.password == "this shouldn't exist")
            XCTAssertTrue(testUser.politics == "Conservative")
            XCTAssertTrue(testUser.education == "Bachelors")
            XCTAssertTrue(testUser.profession == "Comp. Sci.")
            XCTAssertTrue(testUser.interests == "Something")
            XCTAssertTrue(testUser.dob == dob)
            //TODO: test content and settings
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    /*
     * Test:
     * Malformed JSON
     */

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
