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
    private var transformations: [Transformation] = []
    
    // MARK: - OUTLET -
    @IBOutlet private weak var hImageView: UIImageView!
    @IBOutlet private weak var hNameLabel: UILabel!
    @IBOutlet private weak var hDescriptionLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Detail View Controller - View Did Load")

        
        hDescriptionLabel.numberOfLines = .zero
        configureButton()
        
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
            self?.transformations = transformations.sorted {
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
        guard let heroe = model else { return }
        
        let transformationViewController = TransformationViewController()
        transformationViewController.updateTransformation(hero: heroe, transformations: transformations)
        navigationController?.pushViewController(transformationViewController, animated: true)
        
    }
    
    // MARK: - Fucntion
    func update(model: Hero) {
        self.model = model
    }
    
    func update(transformation: Transformation) {
        self.transforamtion = transformation
    }
    
    func updateView(with hero: TableViewCellRepresentable) {
        title = hero.name
        hNameLabel.text = hero.name
        hDescriptionLabel.text = hero.description
        hImageView.setPicture(url: hero.photo)
        button.isHidden = true
        print("Detail View Controller - Updated with Hero: \(hero.name)")

    }
    
    func configureButton() {
        button.backgroundColor = .systemBlue
        button.setTitle("Transformaciones", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }
}

