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
        let allVehicleBrands = await APIManager.getBrandsPerVehicleType(vehicleType: vehicleType)
        await publishVehicleBrands(vehicleBrands: allVehicleBrands)
    }

    // MARK: Brands Per Vehicle Type
}
