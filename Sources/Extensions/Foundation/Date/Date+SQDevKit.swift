//
//  File.swift
//  
//
//  Created by Виталий Баник on 25.03.2021.
//

import Foundation

public extension SQDevKit where Base == Date {
    
    /// Converts date to string
    ///
    /// - Parameters:
    ///   - format: format for DateFormatter.`String`.
    ///   - locale: locale for format.`String`.
    /// - Returns: formatted date string `String`
    func toString(format: String, locale: String = "ru_RU") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: self.base)
    }
    
    /// Get a date in the future by adding the specified time components
    ///
    /// - Parameters:
    ///   - unit: time component for adding.`Calendar.Component`.
    ///   - value: count of units.`Int`.
    /// - Returns: date in the future `Date`
    func add(_ unit: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: value, to: self.base)
    }
    
    /// Set time value in date
    ///
    /// - Parameters:
    ///   - hour: hour value.`Int`.
    ///   - minute: minute value.`Int`.
    /// - Returns: date with setted time `Date`
    func setTime(hour: Int?, minute: Int?) -> Date? {
        let dateComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let calendar = Calendar.current
        var components = calendar.dateComponents(dateComponents, from: self.base)

        components.timeZone = .autoupdatingCurrent
        components.hour = hour ?? .zero
        components.minute = minute ?? .zero

        return calendar.date(from: components)
    }
    
    /// Check date for coincidence with another date (by day)
    ///
    /// - Parameters:
    ///   - date: date for comparison `Date`.
    /// - Returns: comparison result `Bool`
    func isSameDay(date: Date?) -> Bool {
        guard let date = date else { return false }
        return Calendar.current.compare(self.base, to: date, toGranularity: .day) == .orderedSame
    }
    
    /// Returns the day of the week for a date
    ///
    /// - Returns: week for a date number `Int`
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self.base).weekday
    }
      
    /// Returns an array with the names of the months between two dates
    ///
    /// - Parameters:
    ///   - startDate: start date.`Date`.
    ///   - endDate: endDate date.`Date`.
    /// - Returns: array of strings with names of months `[String]`
    static func monthsBetweenDates(startDate: Date?, endDate: Date?) -> [String] {
         var monthsStringsArray = [String]()
         let calendar = Calendar.current

         if let startDate = startDate, let endDate = endDate,
             let diffInMonth = calendar.dateComponents([.month], from: startDate, to: endDate).month {
             
             for month in .zero..<diffInMonth + 1 {
                 var components = calendar.dateComponents([.month], from: startDate)
                 components.month = calendar.component(.month, from: startDate) + month

                if let monthString = calendar.date(from: components)?.sq.toString(format: "LLLL").capitalized {
                     monthsStringsArray.append(monthString)
                 }
             }
         }

         return monthsStringsArray
     }
    
}

extension Date: SQDevKitCompatible {}