//
//  VehicleDetailsViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 19/10/22.
//

import UIKit

class VehicleDetailsViewController: UIViewController {

    var viewModel = VehiclesViewModel()
    var contentView = VehicleDetailsView()

    var vehicleBrandCode: String
    var vehicleBrandType: String
    var vehicleModelCode: String
    var vehicleYearModel: String

    init(
        vehicleBrandCode: String,
        vehicleBrandType: String,
        vehicleModelCode: String,
        vehicleYearModel: String
    ) {
        self.vehicleBrandCode = vehicleBrandCode
        self.vehicleBrandType = vehicleBrandType
        self.vehicleModelCode = vehicleModelCode
        self.vehicleYearModel = vehicleYearModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        Task(priority: .background) {
            await viewModel.fetchVehicle(
                vehicleType: vehicleBrandType,
                brandCode: vehicleBrandCode,
                modelCode: vehicleModelCode,
                yearsCode: vehicleYearModel
            )

            whenFinishLoading()
        }
    }

    func whenFinishLoading() {
        if viewModel.vehicle != nil {
            contentView.vehicle = viewModel.vehicle
            contentView.progressView.isHidden = true
            contentView.cardView.isHidden = false
        }
    }
}
