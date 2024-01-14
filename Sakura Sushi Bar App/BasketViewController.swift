//
//  BasketController.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 09/01/2024.
//

import UIKit
import CoreData

class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let coreDataManager = CoreDataManager.shared

    var items: [SecondBasket?] = [] // List of items in the basket

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var totalView: UIView!
    var totalLabel: UILabel!
    
    var noItemsView: UIView!
    var noItemsLabel: UILabel!
    var noItemsDescLabel: UILabel!
    
    var headingView: UIView!
    var headingLabel: UILabel!
    var headingImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalView = UIView()
        totalLabel = UILabel()
        
        noItemsView = UIView()
        noItemsLabel = UILabel()
        noItemsDescLabel = UILabel()
        
        headingView = UIView()
        headingLabel = UILabel()
        headingImage = UIImageView()
        
        totalView.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        headingView.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingImage.translatesAutoresizingMaskIntoConstraints = false
        noItemsView.translatesAutoresizingMaskIntoConstraints = false
        noItemsLabel.translatesAutoresizingMaskIntoConstraints = false
        noItemsDescLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup UITableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(headingView)
        headingView.addSubview(headingLabel)
        headingView.addSubview(headingImage)
        
        view.addSubview(tableView)
        view.addSubview(totalView)
        totalView.addSubview(totalLabel)
        
        view.addSubview(noItemsView)
        noItemsView.addSubview(noItemsLabel)
        noItemsView.addSubview(noItemsDescLabel)
        
        
        NSLayoutConstraint.activate([
            headingView.topAnchor.constraint(equalTo: view.topAnchor),
            headingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headingView.heightAnchor.constraint(equalToConstant: 233),
            
            headingImage.centerXAnchor.constraint(equalTo: headingView.centerXAnchor),
            headingImage.centerYAnchor.constraint(equalTo: headingView.centerYAnchor),
            headingImage.heightAnchor.constraint(equalToConstant: 75),
            headingImage.widthAnchor.constraint(equalToConstant: 60),
            
            headingLabel.topAnchor.constraint(equalTo: headingImage.bottomAnchor, constant: 8.0),
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headingView.bottomAnchor, constant: 1),
            tableView.bottomAnchor.constraint(equalTo: totalView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            totalView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 140),
            totalView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            totalLabel.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 14.0),
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            noItemsView.topAnchor.constraint(equalTo: headingView.bottomAnchor, constant: 1),
            noItemsView.bottomAnchor.constraint(equalTo: totalView.topAnchor),
            noItemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noItemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            noItemsLabel.topAnchor.constraint(equalTo: noItemsView.topAnchor, constant: 8.0),
            noItemsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noItemsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noItemsLabel.centerXAnchor.constraint(equalTo: noItemsView.centerXAnchor),
            noItemsLabel.centerYAnchor.constraint(equalTo: noItemsView.centerYAnchor),
            
            noItemsDescLabel.topAnchor.constraint(equalTo: noItemsLabel.bottomAnchor, constant: 8.0),
            noItemsDescLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noItemsDescLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.layoutIfNeeded()

        view.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.00)
        totalView.backgroundColor = UIColor(red: 0.95, green: 0.87, blue: 0.87, alpha: 1.00)
        
        // Label Set Up
        totalLabel.font = UIFont(name: "SixCaps", size: 24)
        totalLabel.font = totalLabel.font.withSize(24)
        totalLabel.textColor = .black
        totalLabel.adjustsFontSizeToFitWidth = true
        
        totalLabel.textAlignment = .center
        totalLabel.minimumScaleFactor = 1
        totalLabel.numberOfLines = 1
        
        // no items label
        noItemsLabel.text = "EMPTY BASKET"
        noItemsLabel.font = UIFont(name: "SixCaps", size: 24)
        noItemsLabel.font = noItemsLabel.font.withSize(48)
        noItemsLabel.textColor = .white
        noItemsLabel.adjustsFontSizeToFitWidth = true
        
        noItemsLabel.textAlignment = .center
        noItemsLabel.minimumScaleFactor = 1
        noItemsLabel.numberOfLines = 1
        
        // no items description label
        noItemsDescLabel.text = "Select items from the menu to add them to your basket"
        noItemsDescLabel.font = UIFont(name: "SixCaps", size: 24)
        noItemsDescLabel.font = noItemsDescLabel.font.withSize(16)
        noItemsDescLabel.textColor = .white
        noItemsDescLabel.adjustsFontSizeToFitWidth = true
        
        noItemsDescLabel.textAlignment = .center
        noItemsDescLabel.minimumScaleFactor = 1
        noItemsDescLabel.numberOfLines = 2
        
        // Heading Set up
        headingView.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.00)
        
        headingView.layer.cornerRadius = 5
        
        headingImage.contentMode = .scaleAspectFit
        headingImage.clipsToBounds = true
        headingImage.image = UIImage(named: "logo-no-text.png")
        // 60x75
        print("Image set: \(headingImage.image != nil)")

        headingLabel.text = "BASKET"
        headingLabel.font = UIFont(name: "SixCaps", size: 24)
        headingLabel.font = headingLabel.font.withSize(48)
        headingLabel.textColor = .white
        headingLabel.textAlignment = .center
        headingLabel.adjustsFontSizeToFitWidth = true
        headingLabel.minimumScaleFactor = 2
        headingLabel.numberOfLines = 1

        noItemsView.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.00)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]?.name
        cell.backgroundColor = UIColor(red: 0.95, green: 0.87, blue: 0.87, alpha: 1.00)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        tableView.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.00)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle item selection (e.g., show details, remove from the basket, etc.)
        print("Selected item: \(String(describing: items[indexPath.row]))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var total = 0.0
        
        super.viewWillAppear(animated)
        let res = coreDataManager.fetchAllBaskets()
        
        // this is a  bit odd?
        if let firstBasket = res.first {
            // Explicitly fault the object to ensure all properties are loaded
            let faultedBasket = coreDataManager.viewContext.object(with: firstBasket.objectID) as! SecondBasket
            items = res
            tableView.reloadData()
        }
        
        for i in items {
            total = total + i!.price
        }
        
        if (items.count <= 0 && noItemsView.superview != nil) {
            view.addSubview(noItemsView)
            noItemsView.layer.zPosition = 1
        } else {
            noItemsView.removeFromSuperview()
            noItemsView.layer.zPosition = 0
        }
       
        totalLabel.text = "TOTAL: " + String(format: "%.2f", total)
    }
}
