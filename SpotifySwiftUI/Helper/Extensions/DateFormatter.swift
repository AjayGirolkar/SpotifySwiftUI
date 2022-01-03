//
//  DateFormatter.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 22/12/21.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}
