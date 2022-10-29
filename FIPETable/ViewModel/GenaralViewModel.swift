//
//  VehicleViewModel.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

class GenaralViewModel: ObservableObject {
    var apiManager: APIManager?
    private var vehicleModelResponse: VehicleModelResponse?

    @Published var list: [ArrayResponse] = [] // 1
    @Published var searchedList: [ArrayResponse] = []

    init(apiManager: APIManager? = APIManager()) {
        self.apiManager = apiManager
    }

    // MARK: Brands Per Vehicle Type
    func publishList(list: [ArrayResponse]) async {
        self.list = list
    }

    func fetchData(vehicleType: String) async {
        let complementURL = "\(vehicleType)/marcas"
        let allBrands = try? await APIManager.getArrayResponse(complementURL: complementURL) as [ArrayResponse]
        await publishList(list: allBrands ?? [])
    }

    func fetchData(vehicleType: String, brandCode: String) async {
        let vehicleModelsResponse = await APIManager.getVehicleModelsPerBrand(
            vehicleType: vehicleType,
            brandCode: brandCode
        )

        await publishList(list: vehicleModelsResponse.modelos)
    }

    func fetchData(vehicleType: String, brandCode: String, modelCode: String) async {
        let complementURL = "/\(vehicleType)/marcas/\(brandCode)/modelos/\(modelCode)/anos"
        let allOfYears = try? await APIManager.getArrayResponse(complementURL: complementURL) as [ArrayResponse]
        await publishList(list: allOfYears ?? [])
    }
}
