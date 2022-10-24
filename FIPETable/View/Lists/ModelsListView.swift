//
//  ModelsListView.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 19/10/22.
//

import UIKit

class ModelsListView: UIView {

    lazy var progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .large)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.startAnimating()
        progressView.isHidden = false

        return progressView
    }()

    lazy var modelsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ModelsTableViewCell.self,
            forCellReuseIdentifier: ModelsTableViewCell.identifier
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

extension ModelsListView: SettingsView {
    func setupSubviews() {
        self.addSubview(self.modelsTableView)
        self.addSubview(self.progressView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.modelsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.modelsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.modelsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.modelsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            self.progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
