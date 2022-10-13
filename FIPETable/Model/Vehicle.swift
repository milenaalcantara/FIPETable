//
//  Vehicle.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import Foundation

struct Vehicle: Decodable {
    let valor: String
    let marca: String
    let modelo: String
    let anoModelo: Int
    let combustivel: String
    let codigoFipe: String
    let mesReferencia: String
    let tipoVeiculo: Int
    let siglaCombustivel: String
    let dataConsulta: String
}

/**
 {
 "valor": "R$ 6.022,00",
 "marca": "Fiat",
 "modelo": "Palio EX 1.0 mpi 2p",
 "anoModelo": 1998,
 "combustivel": "Álcool",
 "codigoFipe": "001004-9",
 "mesReferencia": "junho de 2021 ",
 "tipoVeiculo": 1,
 "siglaCombustivel": "Á",
 "dataConsulta": "segunda-feira, 7 de junho de 2021 23:05"
 }
 */
