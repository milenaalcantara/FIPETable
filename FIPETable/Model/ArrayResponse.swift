//
//  ArrayResponse.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 28/10/22.
//

import Foundation

struct ArrayResponse: Codable {
    let nome: String
    let codigo: String

    // Decodificando caso o codigo seja int ou string
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nome = try container.decode(String.self, forKey: .nome)

        do {
            codigo = try String(container.decode(Int.self, forKey: .codigo))
        } catch DecodingError.typeMismatch {
            codigo = try container.decode(String.self, forKey: .codigo)
        }
    }

}
