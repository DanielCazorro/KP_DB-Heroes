//
//  DragonBallHeroesViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    // Modelo del héroe
    private var heroe: Hero?
    
    // Transformación seleccionada
    private var transformation: Transformation?
    
    // Lista de transformaciones disponibles para el héroe
    private var transformations: [Transformation] = []
    
    // MARK: - OUTLET -
    @IBOutlet private weak var hImageView: UIImageView! // Vista de imagen del héroe
    @IBOutlet private weak var hNameLabel: UILabel! // Etiqueta de nombre del héroe
    @IBOutlet private weak var hDescriptionLabel: UILabel! // Etiqueta de descripción del héroe
    @IBOutlet private weak var button: UIButton! // Botón para ver transformaciones
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar la cantidad máxima de líneas para la etiqueta de descripción
        hDescriptionLabel.numberOfLines = .zero
        
        // Configurar el botón, su diseño
        configureButton()
        
        // Verificar si se ha proporcionado un héroe o una transformación
        // Si se proporcionó un héroe, actualizar la vista con los datos del héroe
        // Si se proporcionó una transformación, actualizar la vista con los datos de la transformación
        guard let heroe else {
            if let transformation {
                updateView(with: transformation)
            }
            return
        }
        updateView(with: heroe)
        
        // Obtener el token de autenticación del usuario desde el almacenamiento local
        guard LocalDataModel.getToken() != nil else { return }
        
        // Crear una instancia del modelo de red para realizar solicitudes a la API
        let networkModel = NetworkModel()
        
        // Obtener las transformaciones disponibles para el héroe
        networkModel.getTransformations(for: heroe) { [weak self] result in
            // Manejar el resultado de la solicitud de transformaciones
            guard case let .success(transformations) = result else {
                return
            }
            // Ordenar las transformaciones alfabéticamente por nombre
            self?.transformations = transformations.sorted {
                $0.name.localizedStandardCompare($1.name) == .orderedAscending
            }
            
            // Actualizar la visibilidad del botón en la interfaz de usuario en el hilo principal
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self?.button.isHidden = transformations.isEmpty
                }
            }
        }
    }
    
    // MARK: - IBAction
    
    /// Método llamado cuando se selecciona el botón para ver transformaciones
    @IBAction func didSelectButton(_ sender: UIButton) {
        // Verificar si se ha proporcionado un héroe
        guard let heroe = heroe else { return }
        
        // Crear una instancia del controlador de vista de transformaciones y actualizar sus datos
        let transformationViewController = TransformationViewController()
        transformationViewController.updateTransformation(hero: heroe, transformations: transformations)
        
        // Presentar el controlador de vista de transformaciones
        navigationController?.pushViewController(transformationViewController, animated: true)
        
    }
    
    // MARK: - Fucntion
    /// Método para actualizar el modelo del héroe
    func update(model: Hero) {
        self.heroe = model
    }
    
    /// Método para actualizar el modelo de transformación
    func update(transformation: Transformation) {
        self.transformation = transformation
    }
    
    /// Método para actualizar la vista con los datos del héroe
    func updateView(with hero: TableViewCellRepresentable) {
        // Configurar el título de la vista con el nombre del héroe
        title = hero.name
        
        // Actualizar las etiquetas de nombre y descripción con los datos del héroe
        hNameLabel.text = hero.name
        hDescriptionLabel.text = hero.description
        
        // Descargar y establecer la imagen del héroe desde la URL proporcionada
        hImageView.setPicture(url: hero.photo)
        
        // Ocultar el botón de transformaciones si no hay transformaciones disponibles para el héroe
        button.isHidden = true
    }
    
    /// Método para configurar el aspecto del botón
    func configureButton() {
        button.backgroundColor = .systemBlue
        button.setTitle("Transformaciones", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }
}

