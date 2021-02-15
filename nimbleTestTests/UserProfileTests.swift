//
//  UserProfileTests.swift
//  nimbleTestTests
//
//  Created by Katchapon Poolpipat on 15/2/2564 BE.
//

import XCTest

class UserProfileTests: XCTestCase {

    func testDecodeData() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "UserProfile", ofType: "json") else {
            fatalError("UserProfileResponse.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UserProfileResponse.json to String")
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UserProfileResponse.json to Data")
        }
        
        let jsonDecoder = JSONDecoder()
        let userProfile = try! jsonDecoder.decode(UserProfile.self, from: jsonData)
        
        XCTAssertEqual(userProfile.email, "kpoolpipat@gmail.com")
    }

}
