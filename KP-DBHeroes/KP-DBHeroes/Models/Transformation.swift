//
//  Transformation.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import Foundation

struct Transformation: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
}

extension Transformation: TransformHeroes {}
