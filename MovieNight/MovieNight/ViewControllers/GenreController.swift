//
//  GenreController.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

protocol GenreControllerDelegate: class {
    func selectedGenres(_ controller: GenreController, genres: [Int])
    func selectedPeople(_ controller: GenreController, people: [Int])
}

class GenreController: UITableViewController {
    
    weak var delegate: GenreControllerDelegate?
    
    var genres = [Genre]()
    let client = TmdbApiClient()
    var genresId = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)
        
        cell.textLabel?.text = genres[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "peopleSegue" {
            let selectedIndexPaths = tableView.indexPathsForSelectedRows
            selectedIndexPaths?.forEach({ (indexPath) in
                genresId.append(genres[indexPath.row].id)
            })
            delegate?.selectedGenres(self, genres: genresId)
            
            let destionation = segue.destination as! PeopleController
            destionation.delegate = self
            for i in 1...5 {
                client.getPeople(page: "\(i)") { (result) in
                    switch result {
                    case .success(let people):
                        destionation.people += people.results
                        destionation.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
        }
    }
}

extension GenreController: PeopleControllerDelegate {
    func selectedPeople(_ controller: PeopleController, people: [Int]) {
        delegate?.selectedPeople(self, people: people)
    }
}
