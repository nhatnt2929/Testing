//
//  HomeViewController.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import UIKit
import Reusable

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = ["dog", "cat", "bird", "elephant", "crocodile", "bears", "lion", "tiger", " shark"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUITesting()
        loadUI()
    }
}

extension HomeViewController {
    fileprivate func setUpUITesting() {
        view.accessibilityLabel = AccessibilityLabels.home_accessibility
    }
    
    fileprivate func loadUI() {
        tableView.register(cellType: HomeCell.self)
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = AccessibilityIdentifiers.home_tableView_accessibility
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeCell.self)
        cell.name = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home
}
