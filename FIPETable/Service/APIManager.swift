//
//  API.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

class APIManager {
    static private let baseURL = "https://brasilapi.com.br/api/fipe"
    static private let decoder = JSONDecoder()

    // MARK: Get Vehicles

    static func getVehicleBrands(vehicleType: String) async -> [VehicleBrand] {
        let url = URL(string: "\(baseURL)/marcas/v1/\(vehicleType)/")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let allVehicleBrands = try decoder.decode([VehicleBrand].self, from: data)

            print("Veículos: \(allVehicleBrands)")

            return allVehicleBrands
        } catch {
            print("Error: \(error)") // remover depois, lançar um modal ou screen not found
            return []
        }
    }
}
