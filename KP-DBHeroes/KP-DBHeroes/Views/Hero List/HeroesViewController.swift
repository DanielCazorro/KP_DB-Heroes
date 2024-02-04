//
//  HeroesViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

/// Clase que maneja la vista de héroes
class HeroesViewController: UIViewController {
    
    // MARK: - View State
    /// Estado de la vista: lista de personajes
    private var characters: [Hero] = []
    
    // MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración del título de la vista
        title = "Heroes"
        
        // Mostrar la barra de navegación
        navigationController?.navigationBar.isHidden = false
        
        // Registrar la celda personalizada para la tabla
        tableView?.register(UINib(nibName: HeroesCell.identifier, bundle: nil), forCellReuseIdentifier: HeroesCell.identifier)
        
        // Crear una instancia del modelo de red y obtener los héroes
        let networkModel = NetworkModel()
        networkModel.getHeroes { [weak self] result in
            // Manejar el resultado de la solicitud de héroes
            guard case let .success(heroes) = result else {
                return
            }
            // Actualizar la lista de personajes y recargar la tabla en el hilo principal
            self?.characters = heroes
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HeroesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Número de secciones en la tabla (en este caso solo una)
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Número de filas en la sección (número de personajes)
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configurar y retornar la celda de la tabla
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroesCell.identifier, for: indexPath) as? HeroesCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No data"
            return cell
        }
        // Configurar la celda con los datos del personaje correspondiente
        cell.configure(character: characters[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HeroesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Acción cuando se selecciona una fila (personaje) en la tabla
        print("Selected row at index \(indexPath.row)")
        
        // Obtener el personaje seleccionado y crear una instancia del controlador de vista de detalle
        let character = characters[indexPath.row]
        let detailViewController = DetailViewController()
        
        // Presentar el controlador de vista de detalle y actualizar los datos del personaje seleccionado
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.update(model: character)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Altura de cada fila en la tabla (uso de dimensiones automáticas)
        return UITableView.automaticDimension
    }
}
