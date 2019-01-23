import Foundation

// Some extentions that make working with swift even easier
public extension Optional where Wrapped == Substring {
    func toString() -> String? {
        if(self==nil) { return nil }
        else { return String(self!) }
    }
}

public extension Date {
    static func from(_ formattedString:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: formattedString)
    }
}
