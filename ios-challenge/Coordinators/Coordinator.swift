//
//  Coordinator.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

protocol HomeViewControllerDelegate {
    func showList()
}

protocol PropertiesListViewControllerDelegate {
    func showDetail(propertyCode: String, sender: UIViewController)
}
