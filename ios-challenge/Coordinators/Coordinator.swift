//
//  Coordinator.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
