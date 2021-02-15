//
//  SurveyTests.swift
//  nimbleTestTests
//
//  Created by Katchapon Poolpipat on 15/2/2564 BE.
//

import XCTest

class SurveyTests: XCTestCase {

    func testDecodeData() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "Survey", ofType: "json") else {
            fatalError("SurveyResponse.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert SurveyResponse.json to String")
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert SurveyResponse.json to Data")
        }
        
        let jsonDecoder = JSONDecoder()
        let survey = try! jsonDecoder.decode(Survey.self, from: jsonData)
        
        XCTAssertEqual(survey.title, "Scarlett Bangkok")
    }

}
