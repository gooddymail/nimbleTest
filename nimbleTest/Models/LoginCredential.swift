//
//  LoginCredential.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import Foundation
import Alamofire

struct LoginCredential: Codable, AuthenticationCredential {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiration: Date
    
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
    
    enum CodingKeys: String, CodingKey {
        case attributes
    }
    
    enum attributesCodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiration = "expires_in"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let attributes = try container.nestedContainer(keyedBy: attributesCodingKeys.self, forKey: .attributes)
        accessToken = try attributes.decode(String.self, forKey: .accessToken)
        refreshToken = try attributes.decode(String.self, forKey: .refreshToken)
        tokenType = try attributes.decode(String.self, forKey: .tokenType)
        
        let timeInterval = try attributes.decode(Double.self, forKey: .expiration)
        expiration = Date(timeIntervalSinceNow: timeInterval)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var attributes = container.nestedContainer(keyedBy: attributesCodingKeys.self, forKey: .attributes)
        try attributes.encode(accessToken, forKey: .accessToken)
        try attributes.encode(refreshToken, forKey: .refreshToken)
        try attributes.encode(tokenType, forKey: .tokenType)
        try attributes.encode(expiration.timeIntervalSinceNow, forKey: .expiration)
    }
}
