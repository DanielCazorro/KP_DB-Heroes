//
//  HeroListViewController.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import UIKit

class HeroListViewController: UIViewController {

    @IBOutlet weak var heroListViewTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hero"
        heroListViewTable.rowHeight = 140
        heroListViewTable.register(UINib(nibName: CellTableView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: <#T##String#>)
        

    }
    
    var model: [TransformHeroes]
    
    init(model: [TransformHeroes]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
