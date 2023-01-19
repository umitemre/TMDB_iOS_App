//
//  StringDate+Extensions.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 16.01.2023.
//

import Foundation

extension Optional where Wrapped == String {
    func toAmericanShortDate() -> String? {
        guard let dateString = self else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}
