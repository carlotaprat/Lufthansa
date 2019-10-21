import Foundation

class DateHelper {

    let dateFormat =  "YYYY-MM-dd"

    static var app: DateHelper = {
        return DateHelper()
    }()
        
    func getString(from: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let result = formatter.string(from: from)
        return result
    }
}
