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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapEntrarButton(_ sender: Any) {
        model.login(
            user: usernameTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { [weak self] result in
            switch result {
                case let .success(token):
                    print("Succes")
                    self?.model.getHeroes {  result in
                        switch  result {
                            case let .success(heroes):
                                DispatchQueue.main.async {
                                    self?.goToHeroList(heroes: heroes)
                                }
                            case let .failure(error):
                                print("error \(error)")
                        }
                    }
                case let .failure(error):
                    print("error \(error)")
            }
        }
    }

        }

extension LoginViewController {
    func goToHeroList(heroes: [Hero]) {
        let heroList = HeroListViewController(model: heroes)
        self.navigationController?.setViewControllers([heroList], animated: true)
    }
}
