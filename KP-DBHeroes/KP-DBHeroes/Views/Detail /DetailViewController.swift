//
//  DetailViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 25/9/23.
//

import UIKit

class HeroesDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var heroeImage: UIImageView!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeDescription: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var transformationsButton: UIButton!
    
    // MARK: - Init
    var model: TransformHeroes
    var modelTransformations: [TransformHeroes] = []
    
    init( model: TransformHeroes) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        heroeDescription.sizeToFit()
        DispatchQueue.main.async {
            self.syncModelwithView()
            self.transformationsButton.isHidden = true
            self.transformationsButton.isHidden = true
            NetworkModel().getTransformations(
                for: self.model
            ) {  result in
                switch result {
                    case let .success(transformations):
                        DispatchQueue.main.async {
                            self.modelTransformations.append(contentsOf: transformations)
                            if self.modelTransformations.count > 0 {
                                self.transformationsButton.isHidden = false
                                self.bottomView.isHidden = false
                            }
                        }
                    case let .failure(error):
                        print("\(error)")
                }
            }
        }
    }
    
    // MARK: - Navigation
    @IBAction func transformationsAction(_ sender: Any) {
        let navigationToTransforms = HeroListViewController(model: modelTransformations)
        self.navigationController?.show(navigationToTransforms,
                                        sender: nil)
    }
}

// MARK: - Extensiones
extension HeroesDetailViewController {
    func syncModelwithView (){
        self.title = model.name
        heroeName.text = model.name
        heroeDescription.text = model.description
        heroeImage.imageSet(for: model.photo)
    }
}
