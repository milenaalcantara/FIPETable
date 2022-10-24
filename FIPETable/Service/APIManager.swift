//
//  API.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

class APIManager {
    static private let baseURL = "https://parallelum.com.br/fipe/api/v1"
    static private let decoder = JSONDecoder()

    // MARK: Get Vehicles

    static func getBrandsPerVehicleType(vehicleType: String) async -> [VehicleBrand] {
        let url = URL(string: "\(baseURL)/\(vehicleType)/marcas")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let allVehicleBrands = try decoder.decode([VehicleBrand].self, from: data)

            return allVehicleBrands
        } catch {
            print("Error: \(error)") // remover depois, lançar um modal ou screen not found
            return []
        }
    }

    static func getVehicleModelsPerBrand(vehicleType: String, brandCode: String) async -> VehicleModelResponse {
        let url = URL(string: "\(baseURL)/\(vehicleType)/marcas/\(brandCode)/modelos")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let allModelsPerBrand = try decoder.decode(VehicleModelResponse.self, from: data)

            return allModelsPerBrand
        } catch {
            print("Error: \(error)")
            return VehicleModelResponse.init(modelos: [])
        }
    }

    static func getYearsOfVehicleModel(
        vehicleType: String,
        brandCode: String,
        modelCode: String
    ) async -> [VehicleYears] {
        let url = URL(string: "\(baseURL)/\(vehicleType)/marcas/\(brandCode)/modelos/\(modelCode)/anos")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let allYearsOfModel = try decoder.decode([VehicleYears].self, from: data)

            return allYearsOfModel
        } catch {
            print("Error: \(error)")
            return []
        }
    }

    static func getVehicle(
        vehicleType: String,
        brandCode: String,
        modelCode: String,
        yearsCode: String
    ) async -> Vehicle {
        let url = URL(string: "\(baseURL)/\(vehicleType)/marcas/\(brandCode)/modelos/\(modelCode)/anos/\(yearsCode)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let vehicle = try decoder.decode(Vehicle.self, from: data)

            return vehicle
        } catch {
            print("Error: \(error)")
            return Vehicle(
                valor: "",
                marca: "",
                modelo: "",
                anoModelo: 0,
                combustivel: "",
                codigoFipe: "",
                mesReferencia: "",
                tipoVeiculo: 0,
                siglaCombustivel: ""
            )
        }
    }

}
