//
//  Hero.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import Foundation

struct Hero: CharacterProtocol {
    let id: String
    let url: URL?
    let title: String
    let description: String

    static func fetchCharacter(completion: @escaping ([Hero]) -> Void) {
        let client = NetworkModel()

        client.fetchHeroes(requestData: DBHeroRequest(name: "")) { result in
            switch result {
            case .success(let response):
                let heroes = response.map { hero in
                    Hero(id: hero.id, url: URL(string: hero.photo), title: hero.name, description: hero.description)
                }
                completion(heroes)
            case .failure:
                completion([])
            }

        }
    }
}
