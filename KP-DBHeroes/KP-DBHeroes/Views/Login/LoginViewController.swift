//
//  LoginViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

/// Clase que maneja la vista de inicio de sesión
class LoginViewController: UIViewController {
    
    // MARK: - IBOUTLET -
    @IBOutlet weak var emailTextField: UITextField! // Campo de texto para introducir el email
    @IBOutlet weak var passwordTextfield: UITextField! // Campo de texto para introducir la contraseña
    @IBOutlet weak var loginButton: UIButton! // Botón para iniciar sesión
    
    // MARK: - ACTION -
    /// Método llamado cuando se toca el botón de inicio de sesión
    @IBAction func didTapLogin(_ sender: UIButton) {
        // Obtenemos el email y la contraseña de los campos de texto, asegurándonos de que no sean nulos
        let email = emailTextField.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        // Creamos una instancia del modelo de red para manejar las solicitudes a la API
        let client = NetworkModel()
        
        // Realizamos la solicitud de inicio de sesión al servidor utilizando el modelo de red
        client.login(user: email, password: password) { [weak self] result in
            // Comprobamos si la solicitud de inicio de sesión fue exitosa
            guard case let .success(token) = result else {
                return // Si no fue exitosa, no hacemos nada más
            }
            
            // Si la solicitud de inicio de sesión fue exitosa y se obtuvo un token no vacío,
            // realizamos cambios en la interfaz de usuario en el hilo principal
            DispatchQueue.main.async {
                if !token.isEmpty {
                    // Creamos una instancia del controlador de vista de héroes y lo establecemos como la vista actual
                    let heroesViewController = HeroesViewController()
                    self?.navigationController?.setViewControllers([heroesViewController], animated: true)
                }
            }
        }
    }
}
