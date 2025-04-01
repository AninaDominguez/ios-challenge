//
//  SplashScreenViewController.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 31/3/25.
//

import UIKit

final class SplashViewController: UIViewController {
    var onAnimationFinished: (() -> Void)?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logoApp"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogo()
    }
    
    private func animateLogo() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.finishSplash()
        }
    }
    
    private func finishSplash() {
        UIView.animate(withDuration: 0.8, animations: {
            self.view.alpha = 0.0
        }) { _ in
            self.onAnimationFinished?()
        }
    }
}
