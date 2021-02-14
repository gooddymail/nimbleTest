//
//  OAuthAuthenticator.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import Foundation
import Alamofire

class OAuthenticator: Authenticator {
    typealias Credential = LoginCredential
    
    func apply(_ credential: Credential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }
    
    func refresh(_ credential: Credential, for session: Session, completion: @escaping (Result<Credential, Error>) -> Void) {
        let parameters: [String: String] = ["grant_type": "refresh_token",
                                            "refresh_token": credential.refreshToken,
                                            "client_id": "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE",
                                            "client_secret": "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"]
        
        AF.request("https://survey-api.nimblehq.co/api/v1/oauth/token", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: ResponseData<LoginCredential>.self) { (response) in
                switch response.result {
                case .success(let responseData):
                    LoginSession.share.credential = responseData.data
                    completion(.success(responseData.data))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        
        return response.statusCode == 401
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: Credential) -> Bool {
        
         let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
         return urlRequest.headers["Authorization"] == bearerToken
    }
}
