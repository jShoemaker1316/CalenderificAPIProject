//
//  Holiday.swift
//  CalenderificAPIProject
//
//  Created by Jonathan Shoemaker on 6/17/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import Foundation


//1 create the data model. work from inside out with the Rested app's info to give us a struct. Endgame is the dictionary for "holidays"

//5 create the response whioch is all the info we've seen so far. correlates to "response" from api. this struct maps to info to repsonse from API. We must adopt to each API individually.
//6 create new file for Holiday request.
struct HolidayResponse:Decodable {
    var response:Holidays
}


//4 continuing to work backwards create struct for Holidays which creates an array for HolidayDetail objects. This also encompasses all holidays on the list, under response.
struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

//3 now create HolidayDetail as we work backwards and use "holidays" that includes "date" so we make a var date: DateInfo from step 2
struct HolidayDetail:Decodable {
    var name:String
    var date:DateInfo
}

//2 to get the date with have to acess the dictionary with the key "date" and within that we'll find the "iso" and we have to map it to our data model.
//decodable makes it easy to decode JSOn info from the website
struct DateInfo:Decodable {
    var iso:String
    
}
