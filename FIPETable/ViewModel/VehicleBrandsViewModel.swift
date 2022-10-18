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
    @Published var searchedVehicleBrands: [VehicleBrand] = []

    init(apiManager: APIManager? = APIManager()) {
        self.apiManager = apiManager
    }

    // MARK: All Brands
    func publishVehicleBrands(vehicleBrands: [VehicleBrand]) async {
        self.vehicleBrands = vehicleBrands
    }

    func fetchVehicleBrands(vehicleType: String) async {
        let allVehicleBrands = await APIManager.getVehicleBrands(vehicleType: vehicleType)
        await publishVehicleBrands(vehicleBrands: allVehicleBrands)
    }

    // MARK: Brands Per Vehicle Type
//    func publishVehicleBrandsPerType(vehicleBrands: [VehicleBrand]) async {
//        self.vehicleBrandsPerType = vehicleBrands
//    }
//
//    func fetchVehicleBrandsPerType(vehicleType: String) async {
//        let allVehicleBrandsPerType = await APIManager.getBrandsPerVehicleType(vehicleType: vehicleType)
//        await publishVehicleBrandsPerType(vehicleBrands: allVehicleBrandsPerType)
//    }
}
