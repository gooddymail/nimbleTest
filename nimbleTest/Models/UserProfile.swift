//
//  UserProfile.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import Foundation

struct UserProfile: Codable {
    let email: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case attributes
    }
    
    enum attributesCodingKeys: String, CodingKey {
        case email
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let attributes = try container.nestedContainer(keyedBy: attributesCodingKeys.self, forKey: .attributes)
        email = try attributes.decode(String.self, forKey: .email)
        avatarURL = try attributes.decode(String.self, forKey: .avatarURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var attributes = container.nestedContainer(keyedBy: attributesCodingKeys.self, forKey: .attributes)
        try attributes.encode(email, forKey: .email)
        try attributes.encode(avatarURL, forKey: .avatarURL)
    }
}
