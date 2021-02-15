//
//  APIRequestTests.swift
//  nimbleTestTests
//
//  Created by Katchapon Poolpipat on 15/2/2564 BE.
//

import XCTest
import Alamofire
import Mocker

class APIRequestTests: XCTestCase {

    func testLoginAPIRequest() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let apiEndpoint = URL(string: "https://survey-api.nimblehq.co/api/v1/oauth/token")!
        let requestExpectation = expectation(description: "Login should be success")
        let onRequestExpectation = expectation(description: "Data request should start")
        
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.post: MockedData.loginJSON.data])
        let parameters: [String: String] = ["grant_type": "password",
                              "email": "kpoolpipat@gmail.com",
                              "password": "12345678",
                              "client_id": "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE",
                              "client_secret": "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"]
        
        mock.onRequest = { request, httpBodyArguments in
            XCTAssertEqual(parameters, httpBodyArguments as? [String: String])
            onRequestExpectation.fulfill()
        }
        mock.register()
        
        sessionManager
            .request(apiEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: ResponseData<LoginCredential>.self) { (response) in
                XCTAssertNil(response.error)
                XCTAssertEqual(response.value?.data.accessToken, "LV-cL5tJ5-dwRSCeCC8nyDLJ5ut6W3f2rsACj104K3Y")
                requestExpectation.fulfill()
            }.resume()
        
        wait(for: [requestExpectation, onRequestExpectation], timeout: 10.0)
    }
    
    func testSurveyAPIRequest() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let apiEndpoint = URL(string: "https://survey-api.nimblehq.co/api/v1/surveys?page[number]=1&page[size]=2")!
        let requestExpectation = expectation(description: "Should success get survey list")
        
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: MockedData.surveyJSON.data])
        mock.register()
        
        sessionManager
            .request(apiEndpoint, method: .get, headers: HTTPHeaders([.authorization(bearerToken: "LV-cL5tJ5-dwRSCeCC8nyDLJ5ut6W3f2rsACj104K3Y")]))
            .responseDecodable(of: ResponseData<[Survey]>.self) { (response) in
                XCTAssertNil(response.error)
                XCTAssertEqual(response.value?.data.count, 2)
                requestExpectation.fulfill()
            }.resume()
        
        wait(for: [requestExpectation], timeout: 10.0)
    }
}
