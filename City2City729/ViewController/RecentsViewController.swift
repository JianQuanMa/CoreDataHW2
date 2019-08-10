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
   // lazy var mostRecentTen : [City] = cities.reversed().suffix(10)
    
    
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
     //   return cities.count
        return cities.count > 10 ? 10 : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as! CityTableCell
//        var citiesReversed : [City] = cities.reversed()
//        let city = citiesReversed[indexPath.row]
//        cell.city = city
        
//        if (cities.count != 0){
//            if(cities.count > 10){
//                let mostRecentTen : [City] = cities.reversed().suffix(10)
//
//            }
//            let city = cities[cities.count - 1 - indexPath.row]
//            cell.city = city
//        }
        let reversedCities : [City] = cities.reversed()
        var citiesReversed : [City] = cities.count > 10 ? Array(reversedCities.prefix(10)) : reversedCities
                let city = citiesReversed[indexPath.row]
                cell.city = city
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            cities.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        goToMap(of: city)
    }
    
    
}
