//
//  HeroesCell.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class HeroesCell: UITableViewCell {
    
// MARK: - OUTLET -
    
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heroNameLabel.numberOfLines = .zero
        heroNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        heroDescLabel.numberOfLines = .zero
        heroDescLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }

    func configure(character: CharacterProtocol) {
        heroNameLabel.text = character.title
        heroDescLabel.text = character.description

        if let imageUrl = character.url {
            DispatchQueue.global(qos: .userInteractive).async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async { [weak self] in
                        self?.heroImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
