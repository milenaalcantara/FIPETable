//
//  GenericTableView.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 11/03/23.
//

import UIKit

class GenericTableView<Item, Cell: UITableViewCell>: UITableView, UITableViewDelegate, UITableViewDataSource {

    var items = [Item]()
    var config: (Item, Cell) -> Void
    var selectHandler: (Item) -> Void

//    convenience init(
//        items: [Item],
//        config: @escaping (Item, Cell) -> (),
//        selectHandler: @escaping (Item) -> ()
//    ) {
//        self.items = items
//        self.config = config
//        self.selectHandler = selectHandler
//    }

    init(
        items: [Item],
        config: @escaping (Item, Cell) -> Void,
        selectHandler: @escaping (Item) -> Void
    ) {
        self.items = items
        self.config = config
        self.selectHandler = selectHandler
        super.init(frame: .zero, style: .plain)

        self.delegate = self
        self.dataSource = self
        self.register(Cell.self, forCellReuseIdentifier: "Cell")
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath
        ) as? Cell else { return UITableViewCell() }
        config(items[indexPath.row], cell)
        return cell
    }
}
