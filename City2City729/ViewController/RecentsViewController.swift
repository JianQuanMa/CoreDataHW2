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
    
    var date : Date? = nil
    
    var cities = [City]() {
        didSet {
            date = Date()
            recentsTableView.reloadData()
        }
    }
    //    var date : Date! {
    //        didSet {
    //            visitedTimeLabel.text = date.description
    //        }
    //    }
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
        
        recentsTableView.register(UINib(nibName: RecentTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: RecentTableViewCell.identifier)
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
          let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier, for: indexPath) as! RecentTableViewCell

        let city = cities[indexPath.row]
        cell.city = city
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            cities.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        goToMap(of: city)
    }
    
    
}
