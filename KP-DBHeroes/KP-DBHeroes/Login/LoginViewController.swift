//
//  LoginViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var entrarButton: UIStackView!
    
    private let model = NetworkModel()
    
    @IBAction func tapEntrarButton(_ sender: Any) {
        model.login(
                    user: usernameTextField.text ?? "",
                    password: passwordTextField.text ?? ""
                ) { [weak self] result in
                    switch result {
                        case let .success(token):
                            print("Token: \(token)")
                            self?.model.getHeroes { result in
                                switch result {
                                    case let .success(heroes):
                                        print("Heroes: \(heroes)")
                                        let goku = heroes[3]
                                        self?.model.getTransformations(
                                            for: goku
                                        ) { result in
                                            switch result {
                                                case let .success(transformations):
                                                    print("Transformations: \(transformations)")
                                                case let .failure(error):
                                                    print("Error: \(error)")
                                            }
                                        }
                                        
                                    case let .failure(error):
                                        print("Error: \(error)")
                                }
                            }
                        case let .failure(error):
                            print("Error: \(error)")
                    }
                }
            }
            
            
            override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
            }
        }
