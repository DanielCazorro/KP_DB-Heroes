//
//  CellTableView.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 25/9/23.
//

import UIKit

class CellTableView: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    static let identifier = "CellTableView"

    override func awakeFromNib() {

    }
    
    func configureCell(model: TransformHeroes) {
        cellName.text = model.name
        cellDescription.text = model.description
                
        if let url = URL(string: model.photo.absoluteString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) { cellImageView.image = image} else {
                    // Si no se pudo cargar la imagen, puedes asignar una imagen por defecto o manejar el error de alguna otra manera.
                    cellImageView.image = UIImage(named: "defaultImage") }
    }
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
        self.clipsToBounds = true
        self.layer.cornerRadius = (frame.size.width - 250) / 2
    }
}
