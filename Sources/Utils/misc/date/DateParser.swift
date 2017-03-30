import Foundation

class DateParser {
    /**
     * Returns relative time like: 2y, 11m, 3w, 4h, 2d, 5m,  3sec (aka: time ago)
     * NOTE: the approche bellow is Naive. There are more elegant ways of doing this. But this offers more customization in the future
     * EXAMPLE: DateParser.relativeTime(NSDate(),today.offsetByDays(-3))//Output: [(3,"d")]
     */
    static func relativeTime(_ a:Date,_ b:Date) -> [(value:Int,type:String)]{
        let calendar:Calendar = Calendar.current
        let aComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: a)
        let bComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: b)
        let yearsAgo:Int = aComponents.year! - bComponents.year!//cur year - year = 0
        let monthsAgo:Int = aComponents.month! - bComponents.month!//cur month - month = 0
        let daysAgo:Int = aComponents.day! - bComponents.day!//cur day - day = 0
        var weeksAgo:Int = 0
        if(daysAgo >= 7){
            weeksAgo = daysAgo / 7
        }
        let hoursAgo:Int = aComponents.hour! - bComponents.hour!//cur hour - hour = 0
        let minutesAgo:Int = aComponents.minute! - bComponents.minute!//cur min - min = 0
        let secondsAgo:Int = aComponents.second! - bComponents.second!//cur sec - sec = 4
        //result: 4s ago
        let timeUnits:[(value:Int,type:String)] = [(yearsAgo,"y"),(monthsAgo,"M"),(weeksAgo,"w"),(daysAgo,"d"),(hoursAgo,"h"),(minutesAgo,"m"),(secondsAgo,"s")]
        var relativeTime:[(value:Int,type:String)] = []
        timeUnits.forEach{
            if($0.value > 0){relativeTime.append($0)}
        }
        return relativeTime
    }
    /**
     * Returns a date formated like: 201612035959 aka YYYYMMDDHHMMSS
     * NOTE: The purpouse of this method is to provide an easy way to sort dates (as this format is as sortable as it gets)
     * TRIVIA: The name of this time format: ODBC canonical (some argue it's the ISO 8601 format)
     * TRIVIA: The name descendingDate is a name that describes what the format does. It is not the official name (alt: chronologically descending)
     */
    static func descendingDate(_ date:Date) -> String{
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr:String = formatter.string(from: date)
        //Swift.print("dateTimePrefix: " + "\(dateTimePrefix)")
        return dateStr
    }
    /**
     * Returns a date instance for time components like: 2016,11,03,15,49,59
     */
    static func createDate(_ year:Int? = nil,_ month:Int? = nil,_ day:Int? = nil,_ hour:Int? = nil,_ minute:Int? = nil,_ second:Int? = nil)->Date?{
        let calendar = Calendar.current
        var components = DateComponents()
        if(year != nil){components.year = year!}
        if(month != nil){components.month = month!}
        if(day != nil){components.day = day!}
        if(hour != nil){components.hour = hour!}
        if(minute != nil){components.minute = minute!}
        if(second != nil){components.second = second!}
        return calendar.date(from: components)
    }
    /**
     * NOTE: there are also other date styles aviable: MediumStyle, FullStyle, NoStyle, ShortStyle, LongStyle, "EEEE"
     * NOTE: some date style examples: convertedDate: Thursday, 8 December 2016 convertedDate: 8 Dec 2016 convertedDate: 08/12/2016 convertedDate: Thursday
     * EXAMPLE: NSDate().shortDate// outputs: 08/12/2016
     * TODO: move into DateParser
     */
    static func shortDate(_ date:Date) -> String{//TODO: move the content bellow into DateParser
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateStyle = .short//swift 3 -> was: dateFormatter.style.short
        let convertedDate = dateFormatter.string(from:date)
        //Swift.print("convertedDate: " + "\(convertedDate)")
        return convertedDate
    }
    static func monthName(_ date:Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    /**
     * Jan,Feb,Mar etc
     */
    static func shortMonthName(_ date:Date)->String{
        return date.monthName != nil ? String(date.monthName!.subStr(0, 3)) : ""
    }
    /**
     * Returns m,t,w,t,f,s,s for date
     */
    static func shortDayName(_ date:Date)->String{
        return date.dayName != nil ? String(date.dayName!.characters.first!) : ""
    }
    static func dayName(_ date:Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    static func numOfDaysInMonth(_ date:Date)->Int{
        //parts to NSDate:
        let cal = Calendar.current
        //range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        let days = cal.range(of: .day, in: .month, for: date)
        //Swift.print("days: " + "\(days)")
        //Swift.print("days.location: " + "\(days.location)")
        //Swift.print("days.length: " + "\(days.length)")
        return days!.length//swift 3 issue<-fix the RangeExtensions.swift and this will work
    }
    static func numOfDays(_ from:Date,_ to:Date) -> Int{
        return Calendar.current.dateComponents([.day], from: from, to: to).day!
    }
    static func numOfMonths(_ from:Date,_ to:Date) -> Int{
        return Calendar.current.dateComponents([.day], from: from, to: to).month!
    }
}
