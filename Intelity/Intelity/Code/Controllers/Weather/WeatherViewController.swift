//
//  WeatherViewController.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var updateButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    
    private lazy var viewModel = WeatherViewModel(view: self)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.updateWeatherData()
    }
    
    @objc private func refresh() {
        viewModel.updateWeatherData()
    }
}

// MARK: WeatherView
extension WeatherViewController: WeatherView {
    
    func update() {
        switch viewModel.properties {
        case .loading:
            break
        default:
            refreshControl.endRefreshing()
        }
        
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.properties {
        case .loading, .message:
            return 1
        case let .success(list):
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.properties {
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            cell.startAnimating()
            return cell
        case let .message(text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath) as! InformationCell
            cell.fill(text: text) { [weak self] in
                self?.refresh()
            }
            return cell
        case let .success(list):
            guard let weather = list[safe: indexPath.row] else {
                return SimpleCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
            cell.fill(weather: weather, row: indexPath.row)
            return cell
        }
    }
}

// MARK: View setup
extension WeatherViewController {
    
    private func setupView() {
        titleLabel.text = "Current weather"
        updateButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        
        tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        tableView.register(UINib(nibName: "InformationCell", bundle: nil), forCellReuseIdentifier: "InformationCell")
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
        
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
}
