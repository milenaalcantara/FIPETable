//
//  VehicleModelsTableViewCell.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class ModelsTableViewCell: UITableViewCell {
    static let identifier: String = "ModelCell"

    var vehicleModel: VehicleModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.modelName.text = self?.vehicleModel?.nome.capitalized
            }
        }
    }

    private let modelName: UILabel = {
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
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
}

extension ModelsTableViewCell: SettingsView {
    func setupSubviews() {
        self.addSubview(modelName)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            modelName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            modelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
