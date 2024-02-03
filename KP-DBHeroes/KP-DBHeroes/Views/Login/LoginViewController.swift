//
//  LoginViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let client = NetworkModel()

// MARK: - OUTLET -
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!

// MARK: - ACTION -
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextfield.text else { return }
        
        
        client.login(requestData: LoginRequest(username: email, password: password)) { result in
            switch result {
            case .success(_):
                
                let hero = DragonBallHeroesViewController(nibName: "HeroesViewController", bundle: nil)
                let navController = UINavigationController(rootViewController: hero)
                
                self.view.window?.rootViewController = navController
                
            case .failure(_):
             
                let popAlert = UIAlertController(title: "Error", message: "Inicio de sesión fallido. Por favor, inténtalo de nuevo.", preferredStyle: .alert)
                popAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(popAlert, animated: true, completion: nil)
            }
        }
    }
}
