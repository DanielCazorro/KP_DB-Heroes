//
//  HeroesViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class HeroesViewController: UIViewController {

    // MARK: - View State
    private var content: [Hero] = []
    
    // MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configurar título de la vista
        title = "Heroes"
        
        // Mostrar la barra de navegación
        navigationController?.navigationBar.isHidden = false
        
        // Registrar la celda personalizada
        tableView?.register(UINib(nibName: HeroesCell.identifier, bundle: nil), forCellReuseIdentifier: HeroesCell.identifier)
        /*
        // Obtener los personajes y actualizar la tabla cuando estén disponibles
        Hero.fetchCharacter { [weak self] character in
            self?.content = character
            self?.tableView.reloadData()
        }
         */
    }
}

// MARK: - Extensions
/*
// UITableViewDataSource
extension HeroesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Número de secciones en la tabla (en este caso solo una)
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Número de filas en la sección (número de personajes)
        return content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configurar y retornar la celda de la tabla
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroesCell.identifier, for: indexPath) as? HeroesCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No data"
            return cell
        }
        // Configurar la celda con los datos del personaje correspondiente
        cell.configure(character: content[indexPath.row])
        return cell
    }
}

// UITableViewDelegate
extension HeroesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Acción cuando se selecciona una fila (personaje) en la tabla
        let character = content[indexPath.row]
        let detailViewController = DetailViewController()

        navigationController?.pushViewController(detailViewController, animated: true)
        // Actualizar el detalle de la vista con los datos del personaje seleccionado
        detailViewController.update(model: character)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Altura de cada fila en la tabla (uso de dimensiones automáticas)
        return UITableView.automaticDimension
    }
}
*/
