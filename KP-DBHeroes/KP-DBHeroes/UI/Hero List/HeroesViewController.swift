//
//  HeroesViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 30/9/23.
//

import UIKit

class HeroesViewController: UIViewController {

    // MARK: - Properties
    var characters: [CharacterProtocol] = []

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heroes"
        
        // Register custom cell
        tableView.register(UINib(nibName: "HeroesCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
    }
}

// MARK: - UITableViewDataSource

extension HeroesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        
        // Dequeue reusable cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell") as? HeroesCell else {
            return UITableViewCell()
        }
        
        // Configure cell
        cell.configure(character: character)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HeroesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        var image: UIImage?
        
        // Get the image from the selected cell
        if let cell = tableView.cellForRow(at: indexPath) as? HeroesCell {
            image = cell.heroImageView.image
        }

        // Instantiate detail view controller and push it to navigation stack
        let heroDetail = DetailViewController(character: character, image: image)
        navigationController?.pushViewController(heroDetail, animated: true)
    }
}
