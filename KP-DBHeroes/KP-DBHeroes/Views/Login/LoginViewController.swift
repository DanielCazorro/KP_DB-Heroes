//
//  LoginViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOUTLET -
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
// MARK: - ACTION -
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        // Obtenemos el email y la contraseña de los textfields, si están disponibles
        let email = emailTextField.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        // Creamos una instancia del modelo de red para realizar la solicitud de inicio de sesión
        let model = NetworkModel()
        
        // Realizamos la solicitud de inicio de sesión al servidor
        model.login(requestData: LoginRequest(username: email, password: password)) { [weak self] result in
            switch result {
            case .success(_):
                // Si el inicio de sesión es exitoso, creamos la vista de héroes
                let hero = DragonBallHeroesViewController(nibName: "HeroesViewController", bundle: nil)
                let navController = UINavigationController(rootViewController: hero)
                
                // Cambiamos la vista raíz de la ventana para mostrar la vista de héroes
                self?.view.window?.rootViewController = navController
                
            case .failure(_):
                // Si el inicio de sesión falla, mostramos una alerta de error
                let popAlert = UIAlertController(title: "Error", message: "Inicio de sesión fallido. Por favor, inténtalo de nuevo.", preferredStyle: .alert)
                popAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Presentamos la alerta de error
                self?.present(popAlert, animated: true, completion: nil)
            }
        }
    }
}
