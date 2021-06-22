//
//  MenuViewController.swift
//  SideMenuTest
//
//  Created by Esraa Eid on 22/06/2021.
//

import UIKit

protocol MenuViewControllerDelegate : AnyObject{
    func didSelectMenuItem(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOptions: String, CaseIterable{
        case Inspection = "Inspection"
        case Payment = "Payment"
        case Profile = "Profile"
        case Sharing = "Sharing"
        case Subscription = "Subscription"
        case Notification = "Notification"
        case Other = "Other"
        
        var imageName: String {
            switch self{
            case .Inspection:
                return "house"
            case .Payment:
                return "star"
            case .Profile:
                return "airplane"
            case .Sharing:
                return "message"
            case .Subscription:
                return "gear"
            case .Notification:
                return "heart"
            case .Other:
                return "table"
            }
        }
    }

    private let tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = .blue
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .blue
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }


}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.tintColor = .white
        cell.backgroundColor = .blue
        cell.contentView.backgroundColor = .blue
        cell.imageView?.image = UIImage(systemName:  MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
           
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelectMenuItem(menuItem: item)
    }
    
    
}
