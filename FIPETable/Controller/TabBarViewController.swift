//
//  TabBarViewController.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 18/10/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureTabBar()
    }

    func configureTabBar() {
        let motorcyclesVC = BrandListViewController(vehicleBrandType: "motos")
        let carsVC = BrandListViewController(vehicleBrandType: "carros")
        let trucksVC = BrandListViewController(vehicleBrandType: "caminhoes")

        let motorcyclesTabItem = configureTabItem(
            viewController: motorcyclesVC,
            viewTitle: "Marcas",
            iconName: "bicycle",
            tabItemTitle: "Motos"
        )

        let carsTabItem = configureTabItem(
            viewController: carsVC,
            viewTitle: "Marcas",
            iconName: "car",
            tabItemTitle: "Carros"
        )

        let trucksTabItem = configureTabItem(
            viewController: trucksVC,
            viewTitle: "Marcas",
            iconName: "bus",
            tabItemTitle: "Caminhões"
        )

        tabBar.tintColor = .darkGray
        setViewControllers(
            [motorcyclesTabItem, carsTabItem, trucksTabItem],
            animated: true
        )
    }

    func configureTabItem(
        viewController: UIViewController,
        viewTitle: String,
        iconName: String,
        tabItemTitle: String
    ) -> UINavigationController {
        viewController.title = viewTitle
        viewController.navigationItem.largeTitleDisplayMode = .always

        let item = UINavigationController(rootViewController: viewController)
        item.navigationBar.tintColor = .label
        item.tabBarItem = UITabBarItem(
            title: tabItemTitle,
            image: UIImage(systemName: iconName),
            tag: 1
        )
        item.navigationBar.prefersLargeTitles = true

        return item
    }
}
