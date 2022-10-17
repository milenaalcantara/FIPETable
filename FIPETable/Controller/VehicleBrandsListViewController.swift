//
//  ViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 13/10/22.
//

import UIKit

class VehicleBrandsListViewController: UIViewController {

    // cria uma instancia da classe VehicleBrandsViewModel
    var viewModel = VehicleBrandsViewModel()

    // cria uma table view
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView) // adicionando a table na view
        tableView.frame = view.bounds // setando seu tamanho para o tamanho total da tela
        tableView.dataSource = self // informando

        // Trata atividades em segundo plano
        Task(priority: .background) {
            await viewModel.fetchVehicleBrands()

//            switch result {
//            
//            }
            tableView.reloadData()
        }

        /*
         Task(priority: .background) {
           let result = await service.getMovieDetail(id: movie.id)
           switch result {
           case .success(let movieResponse):
             showModal(
               title: movieResponse.originalTitle,
               message: movieResponse.overview
             )
           case .failure(let error):
             showModal(title: "Error", message: error.customMessage)
           }
         }
         */
    }
}

extension VehicleBrandsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.vehicleBrands.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.vehicleBrands[indexPath.row].nome.uppercased()
        // cell.textLabel?.text = viewModel.vehicleBrands.value?[indexPath.row].name

        return cell
    }
}
