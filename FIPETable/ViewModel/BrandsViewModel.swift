//
//  VehicleViewModel.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

class BrandsViewModel: ObservableObject {
    var apiManager: APIManager?

    @Published var vehicleBrands: [VehicleBrand] = [] // 1
    @Published var searchedVehicleBrands: [VehicleBrand] = []

    init(apiManager: APIManager? = APIManager()) {
        self.apiManager = apiManager
    }

    // MARK: Brands Per Vehicle Type
    func publishVehicleBrands(vehicleBrands: [VehicleBrand]) async {
        self.vehicleBrands = vehicleBrands
    }

    func fetchVehicleBrands(vehicleType: String) async {
        let complementURL = "\(vehicleType)/marcas"
        let allBrands = await APIManager.getArrayResponse(complementURL: complementURL) as [VehicleBrand]
        await publishVehicleBrands(vehicleBrands: allBrands)
    }
}
