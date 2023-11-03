//
//  ModelsGeneralListViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 19/10/22.
//

import UIKit

class ModelsGeneralListViewController: UIViewController {

    var viewModel = ModelsViewModel()
    var contentView = ModelsListView()

    var searchController = UISearchController()
    var searching = false

    var activeModels: [VehicleModel] {
        if searching {
            return viewModel.searchedVehicleModels
        }
        return viewModel.vehicleModels
    }

    var vehicleBrandName: String
    var vehicleBrandCode: String
    var vehicleBrandType: String

    init(
        vehicleBrandName: String,
        vehicleBrandCode: String,
        vehicleBrandType: String
    ) {
        self.vehicleBrandName = vehicleBrandName
        self.vehicleBrandCode = vehicleBrandCode
        self.vehicleBrandType = vehicleBrandType
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
        title = "\(String(describing: vehicleBrandName))" // pegar o nome do modelo

        setupTableView()
        setupSearchController()
        Task(priority: .background) {
            await viewModel.fetchVehicleModels(
                vehicleType: vehicleBrandType,
                brandCode: vehicleBrandCode
            )
            whenFinishLoading()
        }
    }

    func whenFinishLoading() {
        if !viewModel.vehicleModels.isEmpty {
            contentView.progressView.isHidden = true
            contentView.modelsTableView.isHidden = false
            contentView.modelsTableView.reloadData()
        }
    }

    // MARK: Table

    func setupTableView() {
        setTableViewDelegates()
    }

    func setTableViewDelegates() {
        contentView.modelsTableView.delegate = self
        contentView.modelsTableView.dataSource = self
    }

    // MARK: SearchBar

    func setupSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "\(localized("search_title_model_list"))"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension ModelsGeneralListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return viewModel.searchedVehicleModels.count
        }

        return viewModel.vehicleModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ModelsTableViewCell.identifier,
            for: indexPath
        ) as? ModelsTableViewCell else { return UITableViewCell() }

        if searching {
            cell.vehicleModel = viewModel.searchedVehicleModels[indexPath.row]
        } else {
            cell.vehicleModel = viewModel.vehicleModels[indexPath.row]
        }
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = YearsGeneralListViewController(
            vehicleBrandCode: vehicleBrandCode,
            vehicleBrandType: vehicleBrandType,
            vehicleModelName: activeModels[indexPath.row].nome,
            vehicleModelCode: String(describing: activeModels[indexPath.row].codigo)
        )

        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ModelsGeneralListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        viewModel.searchedVehicleModels = viewModel.vehicleModels.filter { model in
            model.nome.localizedCaseInsensitiveContains(searchText)
        }

        searching = !viewModel.searchedVehicleModels.isEmpty
        self.contentView.modelsTableView.reloadData()
    }
}
