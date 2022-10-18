//
//  CarsListViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class CarsListViewController: UIViewController {

    var viewModel = VehicleBrandsViewModel()

    let searchController = UISearchController(searchResultsController: nil)
    var searching = false

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 70 // set row height
        table.register(VehicleBrandsTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.vehicleBrandsID)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cars Brands"

        configTableView()
        configSearchController()
        Task(priority: .background) {
            await viewModel.fetchVehicleBrands(vehicleType: "carros")
            tableView.reloadData()
        }
    }

    // MARK: Table

    func configTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        configTableViewConstraints()
    }

    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: SearchBar

    func configSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Brand"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension CarsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return viewModel.searchedVehicleBrands.count
        } else {
            return viewModel.vehicleBrands.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellIdentifiers.vehicleBrandsID,
            for: indexPath
        ) as? VehicleBrandsTableViewCell else { return UITableViewCell() }

        if searching {
            cell.vehicleBrand = viewModel.searchedVehicleBrands[indexPath.row]
        } else {
            cell.vehicleBrand = viewModel.vehicleBrands[indexPath.row]
        }

        return cell
    }
}

extension CarsListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        if !searchText.isEmpty {
            searching = true
            viewModel.searchedVehicleBrands.removeAll()
            filterShearchingResult(searchText: searchText)
        } else {
            searching = false
            viewModel.searchedVehicleBrands.removeAll()
            viewModel.searchedVehicleBrands = viewModel.vehicleBrands
        }

        tableView.reloadData()
    }

    func filterShearchingResult(searchText: String) {
        for brand in viewModel.vehicleBrands {
            compareSearchResult(brand: brand, searchText: searchText)
        }
    }

    func compareSearchResult(brand: VehicleBrand, searchText: String) {
        if brand.nome.lowercased().contains(searchText.lowercased()) {
            viewModel.searchedVehicleBrands.append(brand)
        }
    }
}
