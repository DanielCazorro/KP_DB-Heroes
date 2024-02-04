//
//  SceneDelegate.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Este método se llama cuando la escena va a ser mostrada por primera vez.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Verificamos que la escena sea de tipo UIWindowScene.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // Creamos un UINavigationController para manejar la navegación entre pantallas.
        let navigationController = UINavigationController()
        // Ocultamos la barra de navegación para tener un diseño personalizado.
        navigationController.navigationBar.isHidden = true
        
        // Creamos una instancia del controlador de vista de inicio de sesión.
        let viewController = LoginViewController()
        // Configuramos el controlador de vista como la única vista del navigationController.
        navigationController.setViewControllers([viewController], animated: false)
        
        // Establecemos el navigationController como la vista raíz de la ventana.
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Asignamos la ventana a la propiedad window de la escena.
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
