//
//  YearsGeneralListViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 19/10/22.
//

import UIKit

class YearsGeneralListViewController: UIViewController {

    var viewModel = GenaralViewModel()
    var contentView = ListView()

    var searchController = UISearchController()
    var searching = false

    var activeYears: [ArrayResponse] {
        if searching {
            return viewModel.searchedList
        }
        return viewModel.list
    }

    var vehicleBrandCode: String
    var vehicleBrandType: String
    var vehicleModelName: String
    var vehicleModelCode: String

    init(
        vehicleBrandCode: String,
        vehicleBrandType: String,
        vehicleModelName: String,
        vehicleModelCode: String
    ) {
        self.vehicleBrandCode = vehicleBrandCode
        self.vehicleBrandType = vehicleBrandType
        self.vehicleModelName = vehicleModelName
        self.vehicleModelCode = vehicleModelCode
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
        title = "\(String(describing: vehicleModelName))" // pegar o nome do modelo

        setupTableView()
        setupSearchController()
        Task(priority: .background) {
            await viewModel.fetchData(
                vehicleType: vehicleBrandType,
                brandCode: vehicleBrandCode,
                modelCode: vehicleModelCode
            )
            whenFinishLoading()
        }
    }

    func whenFinishLoading() {
        if !viewModel.list.isEmpty {
            contentView.progressView.isHidden = true
            contentView.tableView.isHidden = false
            contentView.tableView.reloadData()
        }
    }

    // MARK: Table

    func setupTableView() {
        setTableViewDelegates()
    }

    func setTableViewDelegates() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }

    // MARK: SearchBar

    func setupSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Model"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension YearsGeneralListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return viewModel.searchedList.count
        }

        return viewModel.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        ) as? CustomTableViewCell else { return UITableViewCell() }

        if searching {
            cell.item = viewModel.searchedList[indexPath.row]
        } else {
            cell.item = viewModel.list[indexPath.row]
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = VehicleDetailsViewController(
            vehicleBrandCode: vehicleBrandCode,
            vehicleBrandType: vehicleBrandType,
            vehicleModelCode: vehicleModelCode,
            vehicleYearModel: String(describing: activeYears[indexPath.row].codigo)
        )

        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension YearsGeneralListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        viewModel.searchedList = viewModel.list.filter { year in
            year.nome.localizedCaseInsensitiveContains(searchText)
        }

        searching = !viewModel.searchedList.isEmpty
        contentView.tableView.reloadData()
    }
}
