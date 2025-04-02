//
//  PropertyCellView.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import UIKit

final class PropertyCellView: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var districtText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteDateText: UILabel!
    @IBOutlet weak var viewDetailButton: UIButton!
    
    var onFavoriteTapped: (() -> Void)?
    var onDetailTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        contentView.backgroundColor = .background
        cardView.layer.cornerRadius = 12
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.border.cgColor

        propertyImageView.clipsToBounds = true
        propertyImageView.layer.cornerRadius = 12
        propertyImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bottomView.layer.cornerRadius = 12
        bottomView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        viewDetailButton.addTarget(self, action: #selector(detailTapped), for: .touchUpInside)
    }
    
    func configure(with property: Property,
                   isFavorite: Bool,
                   favoriteDate: String?,
                   image: UIImage?,
                   priceText: String?) {
        favoriteButton.setImage(
            UIImage(systemName: isFavorite ? "heart.fill" : "heart"),
            for: .normal
        )
        favoriteDateText.text = favoriteDate
        propertyImageView.image = image
        districtText?.text = property.district
        self.priceText?.text = priceText
    }
    
    @objc private func favoriteTapped() {
        onFavoriteTapped?()
    }
    
    @objc private func detailTapped() {
        onDetailTapped?()
    }
}
