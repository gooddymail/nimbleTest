//
//  Survey.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import Foundation

struct Survey: Codable {
    let title: String
    let description: String
    let coverImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case attributes
    }
    
    enum attributesCodingKeys: String, CodingKey {
        case title
        case description
        case coverImageURL = "cover_image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let attributes = try container.nestedContainer(keyedBy: attributesCodingKeys.self, forKey: .attributes)
        title = try attributes.decode(String.self, forKey: .title)
        description = try attributes.decode(String.self, forKey: .description)
        coverImageURL = try attributes.decode(String.self, forKey: .coverImageURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var attributes = container.nestedContainer(keyedBy: attributesCodingKeys.self, forKey: .attributes)
        try attributes.encode(title, forKey: .title)
        try attributes.encode(description, forKey: .description)
        try attributes.encode(coverImageURL, forKey: .coverImageURL)
    }
}
