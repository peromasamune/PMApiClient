//
//  ViewController.swift
//  PMApiClient
//
//  Created by Taku Inoue on 2016/05/16.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Properties
    //MARK: Public

    //MARK: Private
    private var tableView : UITableView!
    private var items : [QiitaItem] = []

    //MARK: Constants
    private let CellIdentifier = "Cell"

    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)

        self.requestApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private method
    private func requestApi() {
        let request = ItemsRequest(page: 1, perPage: 10)
        APIClient.request(request).success{ result in
            print(result)
            self.items = result
            self.tableView.reloadData()
        }.failure{ error in
            print(error)
        }

        APIClient.request(request).progress{ progress in
            print(progress)
        }.success{ result in
            print(result)
            self.items = result
            self.tableView.reloadData()
        }.failure{ error in
            print(error)
        }.then { _ in
            print("done")
        }
    }

    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)

        let item = items[indexPath.row]
        cell.textLabel?.text = item.title

        return cell
    }

    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

