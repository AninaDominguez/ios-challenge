//
//  AppCoordinator.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 31/3/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showSplash()
    }
    
    private func showSplash() {
        let splashVC = SplashViewController()
        splashVC.onAnimationFinished = { [weak self] in
            self?.showHome()
        }
        navigationController.setViewControllers([splashVC], animated: false)
    }
    
    private func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.8
        window.layer.add(transition, forKey: kCATransition)
        
        homeCoordinator.start()
    }
}
