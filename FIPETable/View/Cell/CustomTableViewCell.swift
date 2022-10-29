//
//  BrandsTableViewCell.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier: String = "Cell"

    var item: ArrayResponse? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.name.text = self?.item?.nome.capitalized
            }
        }
    }

    private let name: UILabel = {
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
}

extension CustomTableViewCell: SettingsView {
    func setupSubviews() {
        self.addSubview(name)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            name.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
