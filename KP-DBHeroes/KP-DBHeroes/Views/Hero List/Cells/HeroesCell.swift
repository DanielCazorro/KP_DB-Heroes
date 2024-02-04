//
//  HeroesCell.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class HeroesCell: UITableViewCell {
    
    /// Identificador de la celda reutilizable
    static let identifier = "HeroesCell"
    
    // MARK: - IBOutlets -
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    
    // Método llamado cuando se está a punto de reutilizar la celda
    override func prepareForReuse() {
        super.prepareForReuse()
        // Limpia la imagen de la vista de imagen al reutilizar la celda
        heroImageView.image = nil
    }
    
    /// Método llamado cuando la celda se inicializa desde el archivo xib o storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configura el número de líneas y la fuente para las etiquetas de nombre y descripción
        heroNameLabel.numberOfLines = 0
        heroNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        heroDescLabel.numberOfLines = 0
        heroDescLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    // Método para configurar la celda con datos del personaje
    func configure(character: TableViewCellRepresentable) {
        // Configura el tipo de accesorio de la celda (indicador de acceso)
        accessoryType = .disclosureIndicator
        
        // Establece el nombre y la descripción del personaje en las etiquetas correspondientes
        heroNameLabel.text = character.name
        heroDescLabel.text = character.description
        
        // Descarga y establece la imagen del personaje desde la URL proporcionada
        heroImageView.setPicture(url: character.photo)
    }
}


