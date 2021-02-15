//
//  MockedData.swift
//  nimbleTestTests
//
//  Created by Katchapon Poolpipat on 15/2/2564 BE.
//

import Foundation

public final class MockedData {
    public static let loginJSON = Bundle(for: MockedData.self).url(forResource: "LoginAPIResponse", withExtension: "json")!
    public static let surveyJSON = Bundle(for: MockedData.self).url(forResource: "SurveyAPIResponse", withExtension: "json")!
}

internal extension URL {
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
