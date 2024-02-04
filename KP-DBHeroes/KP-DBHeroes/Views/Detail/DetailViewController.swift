//
//  DragonBallHeroesViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private var model: Hero?
    private var transforamtion: Transformation?
    private var hTransformations: [Transformation] = []
    
    // MARK: - OUTLET -
    @IBOutlet private weak var hImageView: UIImageView!
    @IBOutlet private weak var hNameLabel: UILabel!
    @IBOutlet private weak var hDescriptionLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model else {
            if let transforamtion {
                updateView(with: transforamtion)
            }
            return
        }
        updateView(with: model)
        
        guard let token = LocalDataModel.getToken() else { return }
        
        let networkModel = NetworkModel()
        networkModel.getTransformations(for: model) { [weak self] result in
            guard case let .success(transformations) = result else {
                return
            }
            self?.hTransformations = transformations.sorted {
                $0.name.localizedStandardCompare($1.name) == .orderedAscending
            }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self?.button.isHidden = transformations.isEmpty
                }
            }
        }
    }
    
    @IBAction func didSelectButton(_ sender: UIButton) {
        
        
    }
    
    // MARK: - Fucntion
    func update(model: Hero) {
        self.model = model
    }
    
    func updateView(with hero: TableViewCellRepresentable) {
        title = hero.name
        hNameLabel.text = hero.name
        hDescriptionLabel.text = hero.description
        hImageView.setPicture(url: hero.photo)
        button.isHidden = true
    }
}

