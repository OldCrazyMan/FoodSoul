//
//  ConteinerViewController.swift
//  FoodSoul
//
//  Created by Tim Akhmetov on 08.09.2024.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private(set) var menuState: MenuState = .closed
    private let sideMenu = SideMenuViewController()
    private var mainViewController: MenuViewController?
    private var mainNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }
    
    private func addChildViewControllers() {
        addSideMenu()
        addMainViewController()
    }
    
    private func addSideMenu() {
        addChild(sideMenu)
        view.addSubview(sideMenu.view)
        sideMenu.didMove(toParent: self)
    }
    
    private func addMainViewController() {
        mainViewController = ModelBuilder.createMainModule() as? MenuViewController
        mainViewController?.protocolDelegate = self
        let mainNavigationController = UINavigationController(rootViewController: mainViewController!)
        addChild(mainNavigationController)
        view.addSubview(mainNavigationController.view)
        mainNavigationController.didMove(toParent: self)
        self.mainNavigationController = mainNavigationController
    }
}

extension ContainerViewController: MainTabBarControllerDelegate {
    func didTapButtonMenu() {
        print("MainTabBarControllerDelegate")
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            animateMenu(open: true, completion: completion)
        case .opened:
            animateMenu(open: false, completion: completion)
        }
    }
    
    private func animateMenu(open: Bool, completion: (() -> Void)?) {
        
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        let animationDuration: TimeInterval = 0.5
        let animationCurve: UIView.AnimationOptions = .curveEaseOut
        let screenWidth = UIScreen.main.bounds.width
        let targetX: CGFloat = open ? screenWidth - 200 : 0
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: animationCurve) {
            
            if isLandscape {
                self.mainNavigationController?.view.frame.origin.x = targetX / 2.5
            } else {
                self.mainNavigationController?.view.frame.origin.x = targetX
            }
        } completion: { [weak self] (done) in
            if done {
                self?.menuState = open ? .opened : .closed
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
}
