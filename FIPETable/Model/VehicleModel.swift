//
//  VehicleModel.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import Foundation

struct VehicleModelResponse: Codable {
    let modelos: [VehicleModel]
}

struct VehicleModel: Codable {
    let nome: String
    let codigo: Int
}
