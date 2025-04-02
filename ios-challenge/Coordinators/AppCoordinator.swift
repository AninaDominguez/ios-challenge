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
}

// MARK: - Splash & Home Navigation
extension AppCoordinator {
    func showSplash() {
        let splashVC = SplashViewController()
        splashVC.onAnimationFinished = { [weak self] in
            self?.showHome()
        }
        navigationController.setViewControllers([splashVC], animated: false)
    }
    
    func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)

        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.8
        window.layer.add(transition, forKey: kCATransition)
        
        homeCoordinator.start()
    }
}

final class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.onGoToList = { [weak self] in
            self?.showList()
        }
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}

// MARK: - Navigation
extension HomeCoordinator: HomeViewControllerDelegate {
    func showList() {
        let viewModel = PropertiesListViewModel()
        let listViewController = PropertiesListViewController(viewModel: viewModel)
        listViewController.delegate = self
        navigationController.pushViewController(listViewController, animated: true)
    }
}

extension HomeCoordinator: PropertiesListViewControllerDelegate {
    func showDetail(propertyCode: String, sender: UIViewController) {
        let viewModel = PropertyDetailViewModel(propertyCode: propertyCode)
        let detailViewController = PropertyDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
