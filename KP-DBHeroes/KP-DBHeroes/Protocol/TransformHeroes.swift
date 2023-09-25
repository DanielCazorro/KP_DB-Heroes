//
//  TransformHeroes.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 25/9/23.
//

import Foundation

protocol TransformHeroes {
    var name: String { get }
    var description: String { get }
    var id: String { get }
    var photo: URL { get }
}
