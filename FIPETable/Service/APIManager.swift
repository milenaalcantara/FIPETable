//
//  API.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

struct Constants {
    static let baseURL = "https://parallelum.com.br/fipe/api/v1"
    static let decoder = JSONDecoder()
}

enum APIError: Error {
    case invalidURL
}

class APIManager {

    static func getArrayResponse<T: Codable>(complementURL: String) async throws -> [T] {
        guard let url = URL(string: "\(Constants.baseURL)/\(complementURL)") else {
            throw APIError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let allResponses = try Constants.decoder.decode([T].self, from: data)

            return allResponses
        } catch {
            print("Error: \(error.localizedDescription)") // remover depois, lançar um modal ou screen not found
            return []
        }
    }

//    static func getSimpleResponse<T: Decodable>(complementURL: String) async -> T {
//        guard let url = URL(string: "\(baseURL)/\(complementURL)")
    //    else { return Decoder.self as! T } // como mudar isso -> Mentores
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//
//        do {
//            let (data, _) = try await URLSession.shared.data(for: urlRequest)
//            let response = try decoder.decode(T.self, from: data)
//
//            return response
//        } catch {
//            print("Error: \(error)") // remover depois, lançar um modal ou screen not found
//        }
//        return T.self as! T
//    }

    // MARK: Get Vehicles

    static func getVehicleModelsPerBrand(vehicleType: String, brandCode: String) async -> VehicleModelResponse {
        let url = URL(string: "\(Constants.baseURL)/\(vehicleType)/marcas/\(brandCode)/modelos")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let allModelsPerBrand = try Constants.decoder.decode(VehicleModelResponse.self, from: data)

            return allModelsPerBrand
        } catch {
            print("Error: \(error)")
            return VehicleModelResponse.init(modelos: [])
        }
    }

    static func getVehicle(
        vehicleType: String,
        brandCode: String,
        modelCode: String,
        yearsCode: String
    ) async -> Vehicle {
        let url = URL(
            string: "\(Constants.baseURL)/\(vehicleType)/marcas/\(brandCode)/modelos/\(modelCode)/anos/\(yearsCode)"
        )
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let vehicle = try Constants.decoder.decode(Vehicle.self, from: data)

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
