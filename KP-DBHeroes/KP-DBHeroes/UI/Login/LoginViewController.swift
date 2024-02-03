//
//  LoginViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Instancia de la clase NetworkModel para realizar las solicitudes de red
    let client = NetworkModel()
    
    // MARK: - OUTLET -
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - ACTION -
    @IBAction func didTapLogin(_ sender: UIButton) {
        // Se asegura de que ambos campos de texto tengan valores
        guard let email = emailTextField.text, let password = passwordTextfield.text else { return }
        
        // Llama al método login del cliente con las credenciales proporcionadas
        client.login(requestData: LoginRequest(username: email, password: password)) { [weak self] result in
            switch result {
            case .success(_):
                // Si la solicitud es exitosa, crea una instancia de DragonBallHeroesViewController y la muestra en un UINavigationController
                let hero = DragonBallHeroesViewController(nibName: "HeroesViewController", bundle: nil)
                let navController = UINavigationController(rootViewController: hero)
                
                // Establece la nueva instancia de UINavigationController como el controlador de vista raíz
                self?.view.window?.rootViewController = navController
                
            case .failure(_):
                // Si la solicitud falla, muestra una alerta con el mensaje de error
                let popAlert = UIAlertController(title: "Error", message: "Inicio de sesión fallido. Por favor, inténtalo de nuevo.", preferredStyle: .alert)
                popAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self?.present(popAlert, animated: true, completion: nil)
            }
        }
    }
}
