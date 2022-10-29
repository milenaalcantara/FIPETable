//
//  MotorcyclesListViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class BrandListViewController: UIViewController {

    var viewModel = GenaralViewModel()
    var contentView = ListView()

    let searchController = UISearchController(searchResultsController: nil)
    var searching = false

    var activeBrands: [ArrayResponse] {
        if searching {
            return viewModel.searchedList
        }
        return viewModel.list
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
            await viewModel.fetchData(vehicleType: vehicleBrandType)
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
        searchController.searchBar.placeholder = "Search Brand"
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

        viewModel.searchedList = viewModel.list.filter { brand in
            brand.nome.localizedCaseInsensitiveContains(searchText)
        }

        searching = !viewModel.searchedList.isEmpty
        self.contentView.tableView.reloadData()
    }
}
