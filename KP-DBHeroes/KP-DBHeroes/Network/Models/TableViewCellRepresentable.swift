//
//  CharacterProtocl.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 28/9/23.
//

import Foundation

protocol TableViewCellRepresentable {
    var photo: URL { get }
    var title: String { get }
    var description: String { get }
}
