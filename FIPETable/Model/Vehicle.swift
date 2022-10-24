//
//  Vehicle.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

struct Vehicle: Codable {
    let valor: String
    let marca: String
    let modelo: String
    let anoModelo: Int
    let combustivel: String
    let codigoFipe: String
    let mesReferencia: String
    let tipoVeiculo: Int
    let siglaCombustivel: String

    enum CodingKeys: String, CodingKey {
        case valor = "Valor"
        case marca = "Marca"
        case modelo = "Modelo"
        case anoModelo = "AnoModelo"
        case combustivel = "Combustivel"
        case codigoFipe = "CodigoFipe"
        case mesReferencia = "MesReferencia"
        case tipoVeiculo = "TipoVeiculo"
        case siglaCombustivel = "SiglaCombustivel"
    }
}

/*
 {
   "Valor": "R$ 58.862,00",
   "Marca": "GM - Chevrolet",
   "Modelo": "CRUZE HB Sport LT 1.8 16V FlexP. 5p Aut",
   "AnoModelo": 2016,
   "Combustivel": "Gasolina",
   "CodigoFipe": "004399-0",
   "MesReferencia": "janeiro de 2020 ",
   "TipoVeiculo": 1,
   "SiglaCombustivel": "G"
 }
 */
