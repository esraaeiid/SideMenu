//
//  ViewController.swift
//  SideMenuTest
//
//  Created by Esraa Eid on 22/06/2021.
//

import UIKit

enum MenuState {
    case opened
    case closed
}

class ContainerViewController: UIViewController {
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var settingsVC = SettingsViewController()
    
    private var menuState: MenuState = .closed

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        addChildVC()
    }

    private func addChildVC(){
        //menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenu() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?){
        //animate menu
        switch menuState {
        case .closed:
            //open it
            UIView.animate(withDuration: 0.5, delay: 0,
                           usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.width - 100
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .opened
                }
            }

        case .opened:
            //close it
            UIView.animate(withDuration: 0.5, delay: 0,
                           usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
    
}


extension ContainerViewController: MenuViewControllerDelegate {
    func didSelectMenuItem(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        //to perform in parallel
            switch menuItem{
            case .Inspection:
                self.resetIntoHome()
            case .Payment:
                //add child
                self.addSettingsVC()
                
            case .Profile:
                let vc = InfoViewController()
                self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                
            case .Sharing:
                break
            case .Subscription:
                break
            case .Notification:
                break
            case .Other:
                break
            }
        
    }
    
  func addSettingsVC(){
    //add child
    let vc = settingsVC
    homeVC.addChild(vc)
    homeVC.view.addSubview(vc.view)
    vc.view.frame = view.frame
    vc.didMove(toParent: homeVC)
    homeVC.title = vc.title
    }
    
    func resetIntoHome(){
        settingsVC.view.removeFromSuperview()
        settingsVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
    
}
