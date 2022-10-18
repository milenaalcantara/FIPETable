//
//  VehicleBrand.swift
//  FIPETableTests
//
//  Created by Milena Lima de Alcântara on 14/10/22.
//

import XCTest
@testable import FIPETable

final class VehicleBrandTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAtributesVehicleBrandsModel() throws {
        let name = "Fiat"
        let value = String(12)

        let vehicleBrandModel = VehicleBrand(
            nome: name,
            valor: value
        )

        XCTAssertNotNil(vehicleBrandModel)
        XCTAssertEqual(vehicleBrandModel.nome, "Fiat")
        XCTAssertEqual(vehicleBrandModel.valor, "12")
    }
}
