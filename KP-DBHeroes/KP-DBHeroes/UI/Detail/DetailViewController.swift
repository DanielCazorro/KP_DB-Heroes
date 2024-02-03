//
//  DetailViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let hCharacter: CharacterProtocol // El personaje que se mostrará en detalle
    private let hImage: UIImage? // La imagen del personaje, puede ser nula
    private var hTransformations: [Transformations] = [] // Las transformaciones del personaje
    
    // MARK: - Outlets
    
    @IBOutlet private weak var hImageView: UIImageView! // Vista de imagen para mostrar la imagen del personaje
    @IBOutlet private weak var hNameLabel: UILabel! // Etiqueta para mostrar el nombre del personaje
    @IBOutlet private weak var hDescriptionLabel: UILabel! // Etiqueta para mostrar la descripción del personaje
    @IBOutlet private weak var button: UIButton! // Botón para mostrar las transformaciones del personaje
    
    // MARK: - Initialization
    
    // Inicializador personalizado que recibe el personaje y la imagen del personaje
    init(character: CharacterProtocol, image: UIImage?) {
        self.hCharacter = character
        self.hImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:\(coder)) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hCharacter.title // Configura el título de la vista con el nombre del personaje
        hDescriptionLabel.numberOfLines = 0 // Configura el número de líneas de la etiqueta de descripción como cero para mostrar múltiples líneas si es necesario
        configureButton() // Configura el botón
        updateUI() // Actualiza la interfaz de usuario con la información del personaje
        let client = NetworkModel() // Instancia del cliente de red
        client.fetchTransformations(requestData: TransformationRequest(id: hCharacter.id)) { [weak self] result in
            switch result {
            case .success(let transformations): // Si la solicitud de transformaciones es exitosa
                self?.button.isHidden = false // Muestra el botón
                // Mapea las transformaciones recibidas a objetos Transformations y las asigna a la propiedad hTransformations
                self?.hTransformations = transformations.map { transformation in
                    Transformations(url: URL(string: transformation.photo), title: transformation.name, description: transformation.description)
                }
                // Oculta el botón si no hay transformaciones disponibles
                self?.button.isHidden = self?.hTransformations.count == 0
            case .failure(let error): // Si hay un error al obtener las transformaciones
                print("Error fetching transformations: \(error)") // Imprime el error
            }
        }
    }
    
    // MARK: - Actions
    
    // Acción cuando se selecciona el botón de transformaciones
    @IBAction func didSelectButton(_ sender: UIButton) {
        // Crea una instancia del controlador de vista TransformationsViewController con las transformaciones del personaje y lo presenta
        let transformationsVC = TransformationsViewController(transformations: self.hTransformations)
        self.navigationController?.pushViewController(transformationsVC, animated: true)
    }
}

// MARK: - Private Methods

private extension DetailViewController {
    
    // Método para actualizar la interfaz de usuario con la información del personaje
    func updateUI() {
        self.hImageView.image = hImage // Establece la imagen del personaje en la vista de imagen
        self.hNameLabel.text = hCharacter.title // Establece el nombre del personaje en la etiqueta de nombre
        self.hDescriptionLabel.text = hCharacter.description // Establece la descripción del personaje en la etiqueta de descripción
    }
    
    // Método para configurar el botón de transformaciones
    func configureButton() {
        button.isHidden = true // Oculta el botón por defecto
        button.backgroundColor = .systemBlue // Establece el color de fondo del botón como azul
        button.setTitle("Transformaciones", for: .normal) // Establece el título del botón como "Transformaciones"
        button.setTitleColor(.white, for: .normal) // Establece el color del título del botón como blanco
    }
}
