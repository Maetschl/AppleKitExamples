//
//  ViewController.swift
//  TableTest
//
//  Created by Julian Arias Maetschl on 22-04-21.
//

import UIKit

struct SomeItem {
    let title: String = UUID().uuidString
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var content: [SomeItem] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc func refresh() {
        tableView.refreshControl?.beginRefreshing()
        loadData { data in
            self.tableView.refreshControl?.endRefreshing()
            self.content = data
            self.tableView.reloadData()
        }
    }

    func loadData(data: @escaping ([SomeItem])->Void ) {
        let returnData = [SomeItem(), SomeItem(), SomeItem(), SomeItem()]
        // Fake delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            data(returnData)
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SomeCell")
        cell.textLabel?.text = content[indexPath.row].title
        return cell
    }

}

