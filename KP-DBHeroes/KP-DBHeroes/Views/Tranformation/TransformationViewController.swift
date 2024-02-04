//
//  TransformationViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 4/2/24.
//

import UIKit

class TransformationViewController: UIViewController {
    //MARK: - View State
    
    // Lista de transformaciones
    private var transformations: [Transformation] = []
    
    // Héroe seleccionado
    private var model: Hero?
    

    //MARK: - IBOutlet
    
    @IBOutlet weak var tvTransformations: UITableView! // TableView para mostrar las transformaciones
    
    //MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Transformaciones" // Configurar el título de la vista
        
        navigationController?.navigationBar.isHidden = false // Mostrar la barra de navegación
        
        // Registrar la celda personalizada para la tabla
        tvTransformations.register(UINib(nibName: HeroesCell.identifier, bundle: nil), forCellReuseIdentifier: HeroesCell.identifier)
        
        // Recargar los datos de la tabla
        tvTransformations.reloadData()
    }
    
    // Método para actualizar las transformaciones y el héroe seleccionado
    func updateTransformation(hero: Hero, transformations: [Transformation]) {
        self.model = hero
        self.transformations = transformations
    }
}

// MARK: - UITableViewDataSource

extension TransformationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Número de secciones en la tabla (en este caso solo una)
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Número de filas en la sección (número de transformaciones)
        transformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configurar y retornar la celda de la tabla
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroesCell.identifier, for: indexPath) as? HeroesCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No data"
            return cell
        }
        // Configurar la celda con los datos de la transformación correspondiente
        cell.configure(character: transformations[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TransformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Acción cuando se selecciona una fila (transformación) en la tabla
        print("Selected row at index \(indexPath.row)")
        
        // Obtener la transformación seleccionada y crear una instancia del controlador de vista de detalle
        let transformation = transformations[indexPath.row]
        let detailViewController = DetailViewController()
        
        // Presentar el controlador de vista de detalle y actualizar los datos de la transformación seleccionada
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.update(transformation: transformation)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Altura de cada fila en la tabla (uso de dimensiones automáticas)
        return UITableView.automaticDimension
    }
}
