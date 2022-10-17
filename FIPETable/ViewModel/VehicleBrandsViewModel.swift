//
//  VehicleViewModel.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

class VehicleBrandsViewModel: ObservableObject {
    var apiManager: APIManager?
    @Published var vehicleBrands: [VehicleBrand] = [] // 1

    init(apiManager: APIManager? = APIManager()) {
        self.apiManager = apiManager
    }

    func publishVehicleBrands(vehicleBrands: [VehicleBrand]) async {
        self.vehicleBrands = vehicleBrands
    }

    func fetchVehicleBrands() async {
        let allVehicleBrands = await APIManager.getVehicleBrands()
//        allVehicleBrands.sorted(by: <#T##(VehicleBrand, VehicleBrand) throws -> Bool#>)
        await publishVehicleBrands(vehicleBrands: allVehicleBrands)
    }
//    @MainActor
}
