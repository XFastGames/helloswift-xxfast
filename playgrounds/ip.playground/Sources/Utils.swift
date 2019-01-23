import Foundation

// Some extentions on dates to make date parsing easier
public extension Date {
    static func from(_ formattedString:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: formattedString)
    }
}
