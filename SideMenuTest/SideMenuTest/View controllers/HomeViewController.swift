//
//  HomeViewController.swift
//  SideMenuTest
//
//  Created by Esraa Eid on 22/06/2021.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject{
    func didTapMenu()
}



class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                    style: .done,
                    target: self, action: #selector(didTapMenuButton))
    }
    

    @objc func didTapMenuButton(){
        delegate?.didTapMenu()
    }

}
