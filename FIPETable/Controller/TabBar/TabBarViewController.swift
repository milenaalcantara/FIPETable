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

        configTabBar()
    }

    func configTabBar() {
        let motorcyclesVC = MotorcyclesListViewController()
        let carsVC = CarsListViewController()
        let trucksVC = TrucksListViewController()

        let motorcyclesTabItem = configureTabItem(
            viewController: motorcyclesVC,
            viewTitle: "Motorcycle Brands",
            iconName: "bicycle",
            tabItemTitle: "Motorcycles"
        )

        let carsTabItem = configureTabItem(
            viewController: carsVC,
            viewTitle: "Car Brands",
            iconName: "car",
            tabItemTitle: "Cars"
        )

        let trucksTabItem = configureTabItem(
            viewController: trucksVC,
            viewTitle: "Truck Brands",
            iconName: "bus",
            tabItemTitle: "Trucks"
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
