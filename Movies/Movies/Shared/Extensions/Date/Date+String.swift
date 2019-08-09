import Foundation

extension Date {
    var monthDayYearFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"

        return dateFormatter.string(from: self)
    }
}
