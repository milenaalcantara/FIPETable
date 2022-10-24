//
//  ListView.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class BrandsListView: UIView {

    lazy var progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .large)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.startAnimating()
        progressView.isHidden = false

        return progressView
    }()

    lazy var brandsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            BrandTableViewCell.self,
            forCellReuseIdentifier: BrandTableViewCell.identifier
        )
        tableView.rowHeight = 70 // set row height
        tableView.isHidden = true

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        buildLayoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BrandsListView: SettingsView {
    func setupSubviews() {
        self.addSubview(self.brandsTableView)
        self.addSubview(self.progressView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.brandsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.brandsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.brandsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.brandsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            self.progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
