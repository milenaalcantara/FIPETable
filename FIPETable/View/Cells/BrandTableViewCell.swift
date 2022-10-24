//
//  BrandsTableViewCell.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    static let identifier: String = "BrandCell"

    var vehicleBrand: VehicleBrand? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.brandName.text = self?.vehicleBrand?.nome.capitalized
            }
        }
    }

    private let brandName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayoutView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
}

extension BrandTableViewCell: SettingsView {
    func setupSubviews() {
        self.addSubview(brandName)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            brandName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            brandName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
