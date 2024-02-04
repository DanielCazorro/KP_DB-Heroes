//
//  LocalDataModel.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 3/2/24.
//

import Foundation

// Enum para definir constantes relacionadas con el almacenamiento local
private enum Constants {
    static let tokenKey = "KPToken" // Clave para el token en UserDefaults
}

// Clase para manejar el almacenamiento local de datos
final class LocalDataModel {
    
    // UserDefaults para el almacenamiento local
    private static let userDefaults = UserDefaults.standard
    
    // Método para obtener el token guardado en UserDefaults
    static func getToken() -> String? {
        userDefaults.string(forKey: Constants.tokenKey) // Devuelve el token almacenado o nil si no está presente
    }
    
    // Método para guardar el token en UserDefaults
    static func save(token: String) {
        userDefaults.set(token, forKey: Constants.tokenKey) // Guarda el token en UserDefaults bajo la clave especificada
    }
    
    // Método para eliminar el token de UserDefaults
    static func deleteToken() {
        userDefaults.removeObject(forKey: Constants.tokenKey) // Elimina el token de UserDefaults
    }
}
