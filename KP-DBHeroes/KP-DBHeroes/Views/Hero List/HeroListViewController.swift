//
//  HeroListViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class HeroListViewController: UITableViewController{

    @IBOutlet weak var heroListViewTable: UITableView!
    
    var model: [TransformHeroes]
    
    init(model: [TransformHeroes]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Hero"
        heroListViewTable.rowHeight = 140
        heroListViewTable.register(UINib(nibName: CellTableView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: "CellHeroes")
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellHeroes", for: indexPath)
                as? CellTableView else {
            return UITableViewCell()
        }
        let selfHero = model[indexPath.row]
        cell.configureCell(model: selfHero)
        return cell
                
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = HeroesDetailViewController(model: model[indexPath.row])
        self.navigationController?.show(nextVC, sender: true)
    }
}
