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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: WeatherView
extension WeatherViewController: WeatherView {
    
    
}

// MARK: View setup
extension WeatherViewController {
    
    private func setupView() {
        titleLabel.text = "Current weather" // todo local
        setupTableView()
    }
    
    private func setupTableView() {
        
    }
}
