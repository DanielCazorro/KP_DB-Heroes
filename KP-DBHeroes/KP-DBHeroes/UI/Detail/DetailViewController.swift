//
//  DragonBallHeroesViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let hCharacter: CharacterProtocol
    private let hImage: UIImage?
    private var hTransformations: [Transformations] = []
    
// MARK: - OUTLET -
    
    @IBOutlet private weak var hImageView: UIImageView!
    @IBOutlet private weak var hNameLabel: UILabel!
    @IBOutlet private weak var hDescriptionLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    init(character: CharacterProtocol, image: UIImage?) {
        self.hCharacter = character
        self.hImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:\(coder)) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hCharacter.title
        hDescriptionLabel.numberOfLines = .zero
        configureButton()
        updateUI()
        let client = NetworkModel()
        client.fetchTransformations(requestData: TransformationRequest(id: hCharacter.id)) { result in
            switch result {
            case .success(let transformations):
                self.button.isHidden = false
                self.hTransformations = transformations.map { transformation in
                    Transformations(url: URL(string: transformation.photo), title: transformation.name, description: transformation.description)
                }
                self.button.isHidden = self.hTransformations.count == .zero
            case .failure(let error):
                print("Error fetching transformations: \(error)")
            }
        }
    }
    
    @IBAction func didSelectButton(_ sender: UIButton) {
       
        let transformationsVC = TransformationsViewController(transformations: self.hTransformations)
            self.navigationController?.pushViewController(transformationsVC, animated: true)
        
    }
}

private extension DetailViewController {
    
    func updateUI() {
        self.hImageView.image = hImage
        self.hNameLabel.text = hCharacter.title
        self.hDescriptionLabel.text = hCharacter.description
    }
    
    func configureButton() {
        button.isHidden = true
        button.backgroundColor = .systemBlue
        button.setTitle("Transformaciones", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }
}
