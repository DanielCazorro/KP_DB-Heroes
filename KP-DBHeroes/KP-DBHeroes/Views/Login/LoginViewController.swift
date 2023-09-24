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
        
                        DispatchQueue.main.async {
                                        let heroListVC = HeroListViewController(nibName: "HeroListViewController", bundle: nil)
                                        self?.navigationController?.pushViewController(heroListVC, animated: true)
                                    }

                        case let .failure(error):
                            print("Error: \(error)")
                    }
                }
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
            }
        }
