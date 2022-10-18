//
//  VehicleBrandsTableViewCell.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 17/10/22.
//

import UIKit

class VehicleBrandsTableViewCell: UITableViewCell {

    var vehicleBrand: VehicleBrand? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.brandName.text = self?.vehicleBrand?.nome
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(brandName)
        configConstraints()
    }

    func configConstraints() {
        NSLayoutConstraint.activate([
            brandName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            brandName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//        
//    }

}
