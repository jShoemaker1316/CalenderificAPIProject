//
//  HolidaysTableViewController.swift
//  CalenderificAPIProject
//
//  Created by Jonathan Shoemaker on 6/17/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import Foundation
import UIKit
//already made class and override funcs
class HolidaysTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
//22 create new array as a property above viewDidLoad. Fill this array with info after performing search
    var listOfHolidays = [HolidayDetail]() {
//26 with list of Holidays make it a comoputed property and listen for the didSet so that everytime we get new info it will pass to this array and reload in our tableView to get apprpriate holidays for a country. we need to do this on dispatchQueeu for main thread.
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
//27 now set up title view to be number of holidays found
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays Found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
//MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 //28 step 26 calls reloadData on the tableView so we need to update the numberOfRowsInSection according to listOfHolidays count. so change "return 0" to:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
//29 we also need to configure tableViewCell with a Holiday object and access with indexPath and use
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let holiday = listOfHolidays[indexPath.row]
//30 use our celltextLabel and set to holiday and its name and then cell and detailtextLabel to holiday and date and its iso. This will be the first time e access the info stored in the Holiday struct.
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        
        return cell
    }
    
    
    
}

//MARK: SearchBar Func Extension
//provided: adopted the UISearchBarDelegate to an extension to clean things up a little bit. Also added SearchBarbuttonClicked but code wasnt provided. will be done during this project.
extension HolidaysTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//23 now write the code fo this function for clicking the search bar. Then use the holidayRequest struct and initialize it with a countryCode within searchBar. Then use Holiday Request object to get holidays.
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
//24 append a closure and inside use weak self to prevent any retain cycles then switch through results
        holidayRequest.getHolidays{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
//25 look for success case and as object get holidays and assign to self to get holidays from request.
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
            
        }
    }
}
