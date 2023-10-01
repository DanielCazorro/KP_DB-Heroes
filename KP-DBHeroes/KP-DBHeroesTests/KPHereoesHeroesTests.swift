//
//  KP_DBHeroesTests.swift
//  KP-DBHeroesTests
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import XCTest
@testable import KP_DBHeroes

final class KPHereoesTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testExample() throws {
        let hero = Hero.init(id: "Daniel", url: nil, title: "KP", description: "Master")
        XCTAssertEqual(hero.id, "Daniel")
    }
    
    func testDragonBallHeroInitialization() {
        
            let heroInformation = """
            {
                "id": "5",
                "name": "Vegeta",
                "description": "Saiyan prince",
                "photo": "https://example.com/vegeta.jpg"
            }
            """.data(using: .utf8)!

            let decoder = JSONDecoder()
            do {
                let hero = try decoder.decode(DBHeroResponse.self, from: heroInformation)
                XCTAssertEqual(hero.id, "5")
                XCTAssertEqual(hero.name, "Vegeta")
                XCTAssertEqual(hero.description, "Saiyan prince")
                XCTAssertEqual(hero.photo, "https://example.com/vegeta.jpg")
            }
        catch { XCTFail("Decoding failed with error: \(error)") }
        
        }
}
