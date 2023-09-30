//
//  LoginViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    let client = NetworkModel()
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextfield.text else { return }
        client.login(requestData: LoginRequest(username: email, password: password)) { result in
            guard case .success = result else { return }
            let heroes = DragonBallHeroesViewController(nibName: "HeroesViewController", bundle: nil)
            let navigationController = UINavigationController(rootViewController: heroes)
            self.view.window?.rootViewController = navigationController
        }

    }

}

