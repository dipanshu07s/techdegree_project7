//
//  PeopleController.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

protocol PeopleControllerDelegate: class {
    func selectedPeople(_ controller: PeopleController, people: [Int])
}

class PeopleController: UITableViewController {
    
    weak var delegate: PeopleControllerDelegate?
    
    var people = [People]()
    var peopleId = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        
        cell.textLabel?.text = people[indexPath.row].name
        
        return cell
    }
    
    
    @IBAction func done(_ sender: Any) {
        let selectedPeople = tableView.indexPathsForSelectedRows
        selectedPeople?.forEach({ (indexPath) in
            peopleId.append(people[indexPath.row].id)
        })
        delegate?.selectedPeople(self, people: peopleId)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
