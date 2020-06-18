//
//  HolidayRequest.swift
//  CalenderificAPIProject
//
//  Created by Jonathan Shoemaker on 6/17/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import Foundation

//14 define an enum for Error from API Documentation
enum HolidayError:Error {
    case noDataAvailable
    case canNotProcessData
}

//6 create this file after Holiday structs. We will use this to configure  what we would like to access.
//7 create HolidayRequest Struct and define what URL we are going to access.
struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "0184ddc7ca8e47c679ff83030dc6d1bc873df587"
//8 initialize our struct with countryCode and a resourceString with URL request provided on API Documentation.
    init(countryCode:String) {
//10 need to set up the date so that it'll work for any year. and need this for the resource string.
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
//9 Use string interpolation to use API-KEY instead of the full key. Then add the parameters of country and year
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
//11 now we need URL from that
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
//12 use self resource URL to access it in the hole scope of struct holidayRequest
        self.resourceURL = resourceURL
        
    }
    
//13 add one function to be our API request. create Data task using URL session to get info. Once we have info we will have a completion closure (@escaping). Closures are used to passed as an argument to the function AFTER the function returns. when you declare a func that takes a closure as one of its perameters you can write @escaping before the parameters type to indicate that the closure is actually asllowed to escape. Holiday Detail array for success and create (in step 14) HolidayError for Failure. This is used to get info from web API asynchronusly because it takes some time to retrieve the info from the web. So all of that in this closure will be asynchronous with main thread
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
//14 create dataTask use ResoucreURL which is a global property. Then receive data, and responses that we could listen to, and possible error. leave them blank for now so it looks like : let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in.
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
//16 check to see if we received JSON data
            guard let jsonData = data else {
//17 if no JSOn data create a failure
                completion(.failure(.noDataAvailable))
                return
            }
//18 if we HAVE JSON data then create a do catch block. Calling the HolidayResponse struct from the Holiday file.
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
//20 to work with correct data format we rteturn holiday detials with the response and array of holidays
                let holidayDetails = holidaysResponse.response.holidays
//21 make sure it was a success and send along our Holiday Details
                completion(.success(holidayDetails))
            }catch{
//19 and IF this was a failure then we can not process data.
                completion(.failure(.canNotProcessData))
            }
        }
//15 always remember to resume so that its starts accessing ther API
        dataTask.resume()
    }
    
}
