//
//  Transformations.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import Foundation

struct Transformations: CharacterProtocol {
    var id: String = ""
    var url: URL?
    var title: String
    var description: String

    init(url: URL? = nil, title: String, description: String) {
        self.url = url
        self.title = title
        self.description = description
    }

    static func fetchCharacter(completion: ([Transformations]) -> Void) {
        // Not needed
    }
}
