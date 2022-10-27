//
//  YearsTableViewCell.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 19/10/22.
//

import UIKit

class YearsTableViewCell: UITableViewCell {

    static let identifier: String = "YearsCell"

    var yearsModel: VehicleYears? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.yearsDescription.text = self?.yearsModel?.nome.capitalized
            }
        }
    }

    private let yearsDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayoutView()
    }
}

extension YearsTableViewCell: SettingsView {
    func setupSubviews() {
        self.addSubview(yearsDescription)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            yearsDescription.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            yearsDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
