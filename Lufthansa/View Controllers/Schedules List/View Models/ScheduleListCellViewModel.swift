import Foundation

class ScheduleListCellViewModel {
        
    let schedule: Schedule
    let month = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    
    init(schedule: Schedule) {
        self.schedule = schedule
    }
    
    func getDepartureDay() -> String {
       guard let date = schedule.flights.first?.originTime else {
            return ""
        }
        let calendar = Calendar.current
        return String(calendar.component(.day, from: date))
    }
    
    func getDepartureMonth() -> String {
        guard let date = schedule.flights.first?.originTime else {
            return ""
        }
        let calendar = Calendar.current
        return month[calendar.component(.month, from: date)]
    }
    
    func getDepartureAirport() -> String {
        return schedule.flights.first?.departureAirportCode ?? ""
    }
    
    func getDepartureTime() -> String {
        guard let date = schedule.flights.first?.originTime else {
            return ""
        }
        let calendar = Calendar.current
        return String(calendar.component(.hour, from: date)) + ":" + String(calendar.component(.minute, from: date))
    }
    
    func getArrivalDay() -> String {
        guard let arrivalFlight = getLastFlight() else {
            return ""
        }
        let date = arrivalFlight.destinationTime
        let calendar = Calendar.current
        return String(calendar.component(.day, from: date))
    }
    
    func getArrivalMonth() -> String {
        guard let arrivalFlight = getLastFlight() else {
            return ""
        }
        let date = arrivalFlight.destinationTime
        let calendar = Calendar.current
        return month[calendar.component(.month, from: date)]
    }
    
    func getArrivalAirport() -> String {
        guard let arrivalFlight = getLastFlight() else {
           return ""
        }
        return arrivalFlight.destinationAirportCode
    }

    func getArrivalTime() -> String {
        guard let arrivalFlight = getLastFlight() else {
            return ""
        }
        let date = arrivalFlight.destinationTime
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let hourString = parseTime(time: hour)
        let min = calendar.component(.minute, from: date)
        let minString = parseTime(time: min)
        return hourString + ":" + minString
        
    }
    
    func isDirectFlight() -> Bool {
        return schedule.flights.count == 1
    }
    
    func getLastFlight() -> Flight? {
        if schedule.flights.count > 1, let last = schedule.flights.last {
            return last
        } else if let first = schedule.flights.first {
            return first
        } else {
            return nil
        }
    }
    
    func parseTime(time: Int) -> String {
        let timeString = String(time)
        if time < 10 {
            if time == 0 {
                return "00"
            } else {
                return "0" + timeString
            }
        }
        return timeString
    }

        
}
