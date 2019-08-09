//
//  FavoritesViewController.swift
//  City2City729
//
//  Created by mac on 8/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController {
    
    @IBOutlet weak var recentsTableView: UITableView!
    
    var cities = [City]() {
        didSet {
            recentsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecents()
        setUpRightBarButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cities = manager.load()
        
    }
    
    private func setupRecents() {
        
        recentsTableView.register(UINib(nibName: CityTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CityTableCell.identifier)
        recentsTableView.tableFooterView = UIView(frame: .zero)

    }
    
    private func setUpRightBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear history", style: .plain, target: self, action: #selector(rightBarButtonDidTapped))
    }
    
    @objc func rightBarButtonDidTapped(sender: UIBarButtonItem) {
       manager.deleteAllData()
        cities = []
       
    }
    


}

extension RecentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as! CityTableCell
        
        let city = cities[indexPath.row]
        cell.city = city
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        goToMap(of: city)
    }
    
    
}
