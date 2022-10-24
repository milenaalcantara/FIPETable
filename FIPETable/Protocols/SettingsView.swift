//
//  SetupView.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import Foundation

public protocol SettingsView {
    func setupSubviews()
    func setupConstraints()
}

extension SettingsView {
    func buildLayoutView() {
        setupSubviews()
        setupConstraints()
    }
}
