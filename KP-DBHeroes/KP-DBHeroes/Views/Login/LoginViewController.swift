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
        model.login(user: email, password: password) { [weak self] result in
            guard case let .success(token) = result else {
                return
            }
            
            DispatchQueue.main.async{
                if !token.isEmpty {
                    let heroesViewController = HeroesViewController()
                    self?.navigationController?.setViewControllers([heroesViewController], animated: true)
                }
            }
        }
    }
}
