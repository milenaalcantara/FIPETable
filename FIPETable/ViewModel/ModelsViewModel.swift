//
//  oi.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class ModelsViewModel: ObservableObject {
    var apiManager: APIManager?
    private var vehicleModelResponse: VehicleModelResponse?
    @Published var vehicleModels: [VehicleModel] = []
    @Published var searchedVehicleModels: [VehicleModel] = []

    init(apiManager: APIManager? = APIManager()) {
        self.apiManager = apiManager
    }

    // MARK: Brands Per Vehicle Type
    func publishVehicleModels(vehicleModels: [VehicleModel]) async {
        for model in vehicleModels {
            self.vehicleModels.append(model)
        }
    }

    func fetchVehicleModels(vehicleType: String, brandCode: String) async {
        let vehicleModelsResponse = await APIManager.getVehicleModelsPerBrand(
            vehicleType: vehicleType,
            brandCode: brandCode
        )

        await publishVehicleModels(vehicleModels: vehicleModelsResponse.modelos)
    }
}
