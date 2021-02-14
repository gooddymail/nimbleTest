//
//  ResponseData.swift
//  nimbleTest
//
//  Created by Katchapon Poolpipat on 14/2/2564 BE.
//

import Foundation

struct ResponseData<T: Codable>: Codable {
  let data: T
  
  init(jsonData: Data) throws {
    let jsonDecoder = JSONDecoder()
    let responseData = try jsonDecoder.decode(ResponseData<T>.self, from: jsonData)
    
    self = responseData
  }
}
