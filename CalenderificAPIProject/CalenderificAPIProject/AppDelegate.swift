//
//  AppDelegate.swift
//  CalenderificAPIProject
//
//  Created by Jonathan Shoemaker on 6/16/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

//API KEY for https://calendarific.com/account is: 0184ddc7ca8e47c679ff83030dc6d1bc873df587
//API Documentation found here: https://calendarific.com/api-documentation
//List of ISO 3166 Codes: https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes
//provided list of supported Countries: https://calendarific.com/supported-countries
//All requests to our API are supposed to be sent to this endpoint. Below you will find a list of endpoints that the API supports: https://calendarific.com/api/v2
//The api_key should be appended to the url request like:  curl -G https://calendarific.com/api/v2/holidays?api_key=0184ddc7ca8e47c679ff83030dc6d1bc873df587
//USE software called Rested. Build URL example: curl 'https://calendarific.com/api/v2/holidays?&api_key=0184ddc7ca8e47c679ff83030dc6d1bc873df587&country=US&year=2019' WHICH WE REPLACE API KEY

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

