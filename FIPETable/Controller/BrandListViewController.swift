//
//  MotorcyclesListViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class BrandListViewController: UIViewController {

    var viewModel = BrandsViewModel()
    var contentView = BrandsListView()

    let searchController = UISearchController(searchResultsController: nil)
    var searching = false

    var activeBrands: [VehicleBrand] {
        if searching {
            return viewModel.searchedVehicleBrands
        }
        return viewModel.vehicleBrands
    }

    var vehicleBrandType: String

    init(
        vehicleBrandType: String
    ) {
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

        setupTableView()
        setupSearchController()
        Task(priority: .background) {
            await viewModel.fetchVehicleBrands(vehicleType: vehicleBrandType)
            whenFinishLoading()
        }
    }

    func whenFinishLoading() {
        if !viewModel.vehicleBrands.isEmpty {
            contentView.progressView.isHidden = true
            contentView.brandsTableView.isHidden = false
            contentView.brandsTableView.reloadData()
        }
    }

    // MARK: Table

    func setupTableView() {
        setTableViewDelegates()
    }

    func setTableViewDelegates() {
        contentView.brandsTableView.delegate = self
        contentView.brandsTableView.dataSource = self
    }

    // MARK: SearchBar

    func setupSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "\(localized("search_title_brand_list"))"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension BrandListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return viewModel.searchedVehicleBrands.count
        }

        return viewModel.vehicleBrands.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BrandTableViewCell.identifier,
            for: indexPath
        ) as? BrandTableViewCell else { return UITableViewCell() }

        if searching {
            cell.vehicleBrand = viewModel.searchedVehicleBrands[indexPath.row]
        } else {
            cell.vehicleBrand = viewModel.vehicleBrands[indexPath.row]
        }
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brandName = activeBrands[indexPath.row].nome.capitalized
        let brandCode = activeBrands[indexPath.row].codigo
        let viewController = ModelsGeneralListViewController(
            vehicleBrandName: brandName,
            vehicleBrandCode: brandCode,
            vehicleBrandType: vehicleBrandType
        )

        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BrandListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        viewModel.searchedVehicleBrands = viewModel.vehicleBrands.filter { brand in
            brand.nome.localizedCaseInsensitiveContains(searchText)
        }

        searching = !viewModel.searchedVehicleBrands.isEmpty
        self.contentView.brandsTableView.reloadData()
    }
}
