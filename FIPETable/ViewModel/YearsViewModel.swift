//
//  YearsModelViewModel.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 19/10/22.
//

import UIKit

class YearsViewModel: ObservableObject {
    var apiManager: APIManager?

    @Published var yearsModel: [VehicleYears] = []
    @Published var searchedYearsModel: [VehicleYears] = []

    init(apiManager: APIManager? = APIManager()) {
        self.apiManager = apiManager
    }

    // MARK: Brands Per Vehicle Type
    func publishVehicleModels(yearsModel: [VehicleYears]) async {
        for year in yearsModel {
            self.yearsModel.append(year)
        }
    }

    func fetchYearsModel(vehicleType: String, brandCode: String, modelCode: String) async {
        let yearsModelResponse = await APIManager.getYearsOfVehicleModel(
            vehicleType: vehicleType,
            brandCode: brandCode,
            modelCode: modelCode
        )

        await publishVehicleModels(yearsModel: yearsModelResponse)
    }
}
