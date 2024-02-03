//
//  TransformationsViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class TransformationsViewController: HeroesViewController {

    init(transformations: [Transformations]) {
        super.init(nibName: "HeroesViewController", bundle: nil)
        self.characters = transformations
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:\(coder) has not been implemented")
    }
}
