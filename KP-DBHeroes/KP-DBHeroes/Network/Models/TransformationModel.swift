//
//  Transformations.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import Foundation

struct Transformation: Codable, TableViewCellRepresentable {
    let photo: URL
    let id: String
    let name: String
    let description: String
}
