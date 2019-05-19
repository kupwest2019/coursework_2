//
//  Helper_Methods.swift
//
//  Copyright © 2019 group_a. All rights reserved.
//  group fo function for managing the date

import Foundation


class DealWithDate{

    func returnCalendarMonthYear(inputDate : Date) -> DateComponents {
        let calanderDate = Calendar.current.dateComponents([.year, .month], from: inputDate)
        return calanderDate
    }
    
    func returnCalendarDayMonthYear(inputDate : Date) -> DateComponents {
        let calanderDate = Calendar.current.dateComponents([.year, .month, .day], from: inputDate)
        return calanderDate
    }
    
    
    func returnOnlyDayMonthYear(inputDate : Date) -> Date{
        
        let calanderDate = Calendar.current.dateComponents([.year, .month, .day], from: inputDate)
        
        var dateComponents = DateComponents()
        dateComponents.year = calanderDate.year
        dateComponents.month = calanderDate.month
        dateComponents.day = calanderDate.day
        dateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
        dateComponents.hour = 0
        dateComponents.minute = 00
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let cleaned_date = userCalendar.date(from: dateComponents)
        
        print (cleaned_date!)
        
        return cleaned_date!
        
    }
    
    func returnOnlyDayMonthYear_LastDate(inputDate : Date) -> Date{
        
        let calanderDate = Calendar.current.dateComponents([.year, .month, .day], from: inputDate)
        
        var dateComponents = DateComponents()
        dateComponents.year = calanderDate.year
        dateComponents.month = calanderDate.month
        dateComponents.day = calanderDate.day
        dateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
        dateComponents.hour = 23
        dateComponents.minute = 59
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let cleaned_date = userCalendar.date(from: dateComponents)
        
        print (cleaned_date!)
        
        return cleaned_date!
        
    }
    
    func returnDateForCategoryPopulation() -> Date{
        
        
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 1
        dateComponents.day = 30
        dateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
        dateComponents.hour = 0
        dateComponents.minute = 00
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let cleaned_date = userCalendar.date(from: dateComponents)
        
        print (cleaned_date!)
        
        return cleaned_date!
    }
    
    
    
    func returnOnlyDayMonthYear_customDay(inputDate : Date, day: Int) -> Date{
        
        let calanderDate = Calendar.current.dateComponents([.year, .month, .day], from: inputDate)
        
        var dateComponents = DateComponents()
        dateComponents.year = calanderDate.year
        dateComponents.month = calanderDate.month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
        dateComponents.hour = 0
        dateComponents.minute = 00
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let cleaned_date = userCalendar.date(from: dateComponents)
        
        print (cleaned_date!)
        
        return cleaned_date!
        
    }
    
    func returnInfiniteDate() -> Date{
        
        var dateComponents = DateComponents()
        dateComponents.year = 2099
        dateComponents.month = 12
        dateComponents.day = 31
        dateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
        dateComponents.hour = 0
        dateComponents.minute = 00
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let cleaned_date = userCalendar.date(from: dateComponents)
        
        print (cleaned_date!)
        
        return cleaned_date!
        
    }
    
    
    
    // to deal with the end of the day : 23:59...
    func returnOnlyDayMonthYear_customDay_endDate(inputDate : Date, day: Int) -> Date{
        
        let calanderDate = Calendar.current.dateComponents([.year, .month, .day], from: inputDate)
        
        var dateComponents = DateComponents()
        dateComponents.year = calanderDate.year
        dateComponents.month = calanderDate.month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
        dateComponents.hour = 23
        dateComponents.minute = 59
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let cleaned_date = userCalendar.date(from: dateComponents)
        
        print (cleaned_date!)
        
        return cleaned_date!
        
    }
    
    
}

