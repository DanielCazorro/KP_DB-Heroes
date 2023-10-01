//
//  CharacterProtocl.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 28/9/23.
//

import Foundation

protocol CharacterProtocol {
    var id: String { get }
    var url: URL? { get }
    var title: String { get }
    var description: String { get }

    static func fetchCharacter(completion: @escaping ([Self]) -> Void)
}
