//
//  VehiclesViewModel.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 19/10/22.
//

import UIKit

class VehiclesViewModel: ObservableObject {
    var apiManager: APIManager?

    @Published var vehicle: Vehicle?

    init(apiManager: APIManager? = APIManager()) {
        self.apiManager = apiManager
    }

    // MARK: Brands Per Vehicle Type
    func publishVehicles(vehicle: Vehicle) async {
        self.vehicle = vehicle
    }

    func fetchVehicle(vehicleType: String, brandCode: String, modelCode: String, yearsCode: String) async {
        let vehicleResponse = await APIManager.getVehicle(
            vehicleType: vehicleType,
            brandCode: brandCode,
            modelCode: modelCode,
            yearsCode: yearsCode
        )

        await publishVehicles(vehicle: vehicleResponse)
    }
}
