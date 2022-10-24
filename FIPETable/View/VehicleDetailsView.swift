//
//  VehicleDetailsView.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import UIKit

class VehicleDetailsView: UIView {
    var vehicle: Vehicle? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.vehicleModel.text = self?.vehicle?.modelo.uppercased()
                self?.brandView.valueLabel.text = self?.vehicle?.marca.capitalized
                self?.valueView.valueLabel.text = self?.vehicle?.valor.uppercased()
                self?.yearView.valueLabel.text = String(self?.vehicle?.anoModelo ?? 0)
                self?.fuelView.valueLabel.text = self?.vehicle?.combustivel.capitalized
                self?.fipeCodeView.valueLabel.text = self?.vehicle?.codigoFipe.uppercased()
            }
        }
    }

    lazy var progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .large)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.startAnimating()
        progressView.isHidden = false

        return progressView
    }()

    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.isHidden = true

        return view
    }()

    lazy var vehicleModel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    lazy var brandView: DetailCell = {
        let view = DetailCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.titleLabel.text = "Brand: "
        return view
    }()

    lazy var valueView: DetailCell = {
        let view = DetailCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.titleLabel.text = "Value: "
        return view
    }()

    lazy var yearView: DetailCell = {
        let view = DetailCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.titleLabel.text = "Year: "
        return view
    }()

    lazy var fuelView: DetailCell = {
        let view = DetailCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.titleLabel.text = "Fuel: "
        return view
    }()

    lazy var fipeCodeView: DetailCell = {
        let view = DetailCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.titleLabel.text = "FIPE Code: "
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildLayoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension VehicleDetailsView: SettingsView {
    func setupSubviews() {
        self.addSubview(progressView)
        self.cardView.addSubview(vehicleModel)
        self.addSubview(cardView)
        self.addSubview(brandView)
        self.addSubview(valueView)
        self.addSubview(yearView)
        self.addSubview(fuelView)
        self.addSubview(fipeCodeView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.cardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.cardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            self.cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            self.cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.vehicleModel.centerXAnchor.constraint(equalTo: self.cardView.centerXAnchor),
            self.vehicleModel.centerYAnchor.constraint(equalTo: self.cardView.centerYAnchor),
            self.vehicleModel.trailingAnchor.constraint(equalTo: self.cardView.layoutMarginsGuide.trailingAnchor),
            self.vehicleModel.leadingAnchor.constraint(equalTo: self.cardView.layoutMarginsGuide.leadingAnchor),

            self.progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        setupBrandConstraint()
        setupValueConstraint()
        setupYearConstraint()
        setupFuelConstraint()
        setupFipeCodeConstraint()
    }

    func setupBrandConstraint() {
        NSLayoutConstraint.activate([
            self.brandView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.brandView.topAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: 20),
            self.brandView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.brandView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
    }

    func setupValueConstraint() {
        NSLayoutConstraint.activate([
            self.valueView.topAnchor.constraint(equalTo: self.brandView.bottomAnchor),
            self.valueView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.valueView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
    }

    func setupYearConstraint() {
        NSLayoutConstraint.activate([
            self.yearView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.yearView.topAnchor.constraint(equalTo: self.valueView.bottomAnchor),
            self.yearView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.yearView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
    }

    func setupFuelConstraint() {
        NSLayoutConstraint.activate([
            self.fuelView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.fuelView.topAnchor.constraint(equalTo: self.yearView.bottomAnchor),
            self.fuelView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.fuelView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
    }

    func setupFipeCodeConstraint() {
        NSLayoutConstraint.activate([
            self.fipeCodeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.fipeCodeView.topAnchor.constraint(equalTo: self.fuelView.bottomAnchor),
            self.fipeCodeView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.fipeCodeView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
    }
}
