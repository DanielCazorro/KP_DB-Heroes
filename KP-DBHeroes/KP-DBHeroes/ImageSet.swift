//
//  ImageSet.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 25/9/23.
//

import UIKit

extension UIImageView {
    func imageSet(for url: URL) {
        imageDown(url: url) { [weak self] result in
            guard case let .success(image) = result else {
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    private func imageDown(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
    {
        let task = URLSession.shared.dataTask(with: url) {  data, response, _ in
            let result: Result<UIImage, Error>
            defer {
                completion(result)
            }
            guard let data, let image = UIImage(data: data) else {
                result = .failure(NSError(domain: "No image", code: -1))
                return
            }
            result = .success(image)
        }
        task.resume()
    }
}
