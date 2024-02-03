//
//  DBHeroResponse.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import Foundation

struct DBHeroResponse: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: String
}
