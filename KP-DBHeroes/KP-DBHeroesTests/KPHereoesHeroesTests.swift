//
//  KP_DBHeroesTests.swift
//  KP-DBHeroesTests
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import XCTest
@testable import KP_DBHeroes

final class KPHereoesTests: XCTestCase {
    private let goodURL = URL(string: "goodURL")
    private let badURL = URL(string: "badURL")
    
    func testHeroInitialization() {
        guard let goodURL = URL(string: "https://example.com/goku.jpg") else {
                XCTFail("Failed to create URL.")
                return
            }
        
        let hero = Hero(photo: goodURL, id: "1", favorite: true, name: "Goku", description: "Saiyan warrior")
        
        XCTAssertEqual(hero.id, "1")
        XCTAssertEqual(hero.name, "Goku")
        XCTAssertEqual(hero.description, "Saiyan warrior")
        XCTAssertEqual(hero.photo, goodURL)
    }
    
    func testTransformationInitialization() {
        // URL válida para la foto de la transformación
        guard let transformationURL = URL(string: "https://example.com/super-saiyan.jpg") else {
            XCTFail("Failed to create URL.")
            return
        }
        
        // Inicialización de una transformación con valores válidos
        let transformation = Transformation(photo: transformationURL, id: "1", name: "Super Saiyan", description: "Powerful transformation")
        
        // Verificación de los valores de inicialización
        XCTAssertEqual(transformation.id, "1")
        XCTAssertEqual(transformation.name, "Super Saiyan")
        XCTAssertEqual(transformation.description, "Powerful transformation")
        XCTAssertEqual(transformation.photo, transformationURL)
    }
}

//MARK: -  Local DATA Model Test
final class LocalDataModelTests: XCTestCase {
    static let testToken = "TheForceToken"

    override func tearDownWithError() throws {
        LocalDataModel.deleteToken()
    }
    
    func testSaveToken() throws {
        LocalDataModel.save(token: LocalDataModelTests.testToken)
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertEqual(retrievedToken, LocalDataModelTests.testToken, "Retrieved token should be equal to test one")
    }
    
    func testDeleteToken() throws {
        LocalDataModel.save(token: LocalDataModelTests.testToken)
        LocalDataModel.deleteToken()
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertNil(retrievedToken, "There should be no token retrieved")
    }
    
}

//MARK: - ViewCell
class HeroesCellTests: XCTestCase {
    
    func testConfigure() {
        // Prepare test data
        let character = TableViewCellRepresentableMock()
        
        // Prepare cell
        let cell = HeroesCell()
        let heroNameLabel = UILabel()
        let heroDescLabel = UILabel()
        let heroImageView = UIImageView()
        cell.heroNameLabel = heroNameLabel
        cell.heroDescLabel = heroDescLabel
        cell.heroImageView = heroImageView
        
        // Call configure method
        cell.configure(character: character)
        
        // Assertions
        XCTAssertEqual(cell.heroNameLabel.text, character.name)
        XCTAssertEqual(cell.heroDescLabel.text, character.description)

    }
}

// Mock implementation of TableViewCellRepresentable for testing
class TableViewCellRepresentableMock: TableViewCellRepresentable {
    var photo: URL = URL(string: "https://example.com/image.jpg")!
    var name: String = "Test Name"
    var description: String = "Test Description"
}

//MARK: -Transforamtion View
class TransformationViewControllerTests: XCTestCase {
    
    func testTableViewDataSourceMethods() {
        let viewController = TransformationViewController()
        
        // Load the view to trigger viewDidLoad and register the cell
        viewController.loadViewIfNeeded()
        
        guard let tableView = viewController.tvTransformations else {
            XCTFail("TableView is nil")
            return
        }
        // Verify that the tableView's data source is set to the view controller
        XCTAssertTrue(tableView.dataSource === viewController)
        
        // Verify that the number of sections is correct
        XCTAssertEqual(viewController.numberOfSections(in: tableView), 1)
        
        // Test numberOfRowsInSection method
        XCTAssertEqual(viewController.tableView(tableView, numberOfRowsInSection: 0), 0)
        
    }
    
    func testTableViewDelegateMethods() {
        let viewController = TransformationViewController()
        
        // Load the view to trigger viewDidLoad and register the cell
        viewController.loadViewIfNeeded()
        
        guard let tableView = viewController.tvTransformations else {
            XCTFail("TableView is nil")
            return
        }
        
        // Verify that the tableView's delegate is set to the view controller
        XCTAssertTrue(tableView.delegate === viewController)
        
        // Test heightForRowAt method
        let indexPath = IndexPath(row: 0, section: 0)
        let height = viewController.tableView(tableView, heightForRowAt: indexPath)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
}
