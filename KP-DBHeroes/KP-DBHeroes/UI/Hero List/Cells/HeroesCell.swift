//
//  HeroesCell.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class HeroesCell: UITableViewCell {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Al reutilizar la celda, limpiamos la imagen para evitar imágenes en caché incorrectas
        heroImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configuración de las etiquetas de nombre y descripción
        heroNameLabel.numberOfLines = 0 // Permite que el texto se ajuste a múltiples líneas
        heroNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        heroDescLabel.numberOfLines = 0 // Permite que el texto se ajuste a múltiples líneas
        heroDescLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }

    // Configuración de la celda con los datos del personaje
    func configure(character: CharacterProtocol) {
        heroNameLabel.text = character.title // Asigna el título del personaje a la etiqueta de nombre
        heroDescLabel.text = character.description // Asigna la descripción del personaje a la etiqueta de descripción

        // Carga la imagen del personaje desde su URL (si está disponible)
        if let imageUrl = character.url {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        // Asigna la imagen al imageView de la celda
                        self?.heroImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
