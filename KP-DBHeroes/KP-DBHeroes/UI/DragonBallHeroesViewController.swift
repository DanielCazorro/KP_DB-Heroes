//
//  DragonBallHeroesViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class DragonBallHeroesViewController: HeroesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Hero.fetchCharacter { character in
            self.characters = character
            self.tableView.reloadData()
        }
    }
}
