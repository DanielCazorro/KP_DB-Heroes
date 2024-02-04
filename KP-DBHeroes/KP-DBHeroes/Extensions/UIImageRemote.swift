//
//  UIImage+Remote.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 3/2/24.
//

import UIKit

extension UIImageView {
    
    // Método para establecer la imagen de forma asíncrona desde una URL
    func setPicture(url: URL) {
        // Descarga la imagen utilizando URLSession
        downloadUrlSession(url: url) { [weak self] image in
            // Se asegura de actualizar la interfaz de usuario en el hilo principal
            DispatchQueue.main.async {
                // Asigna la imagen descargada a la vista de imagen
                self?.image = image
            }
        }
    }
    
    // Método privado para descargar la imagen utilizando URLSession
    private func downloadUrlSession(url: URL, completion: @escaping (UIImage?) -> Void) {
        // Crea una tarea de descarga de datos con la URL proporcionada
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Comprueba si se recibieron datos y si se puede crear una imagen a partir de ellos
            guard let data = data,
                  let image = UIImage(data: data) else {
                // Si no se puede crear una imagen, llama al bloque de finalización con nil
                completion(nil)
                return
            }
            
            // Si se crea la imagen correctamente, llama al bloque de finalización con la imagen
            completion(image)
            
        }.resume() // Inicia la tarea de descarga
    }
}

