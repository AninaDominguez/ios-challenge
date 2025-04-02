//
//  DateExtension.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import UIKit

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
