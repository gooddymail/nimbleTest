//
//  LoginCredentialTests.swift
//  nimbleTestTests
//
//  Created by Katchapon Poolpipat on 15/2/2564 BE.
//

import XCTest

class LoginCredentialTests: XCTestCase {
    func testDecodeData() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "LoginCredential", ofType: "json") else {
            fatalError("LoginCredentialResponse.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert LoginCredentialResponse.json to String")
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert LoginCredentialResponse.json to Data")
        }
        
        let jsonDecoder = JSONDecoder()
        let loginCredential = try! jsonDecoder.decode(LoginCredential.self, from: jsonData)
        
        XCTAssertEqual(loginCredential.accessToken, "LV-cL5tJ5-dwRSCeCC8nyDLJ5ut6W3f2rsACj104K3Y")
    }
}
