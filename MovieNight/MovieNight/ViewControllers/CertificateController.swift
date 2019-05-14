//
//  CertificateController.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

protocol CertificateControllerDelegate: class {
    func selectedCertificat(_ controller: CertificateController, certificate: Certificate)
    func selectedGenre(_ controller: CertificateController, genres: [Int])
    func selectedPeople(_ controller: CertificateController, people: [Int])
}

class CertificateController: UITableViewController {
    
    weak var delegate: CertificateControllerDelegate?
    
    var certificate = [Certificate]()
    let client = TmdbApiClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return certificate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "certificateCell", for: indexPath)
        
        cell.textLabel?.text = certificate[indexPath.row].certification
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCertificate = certificate[indexPath.row]
        delegate?.selectedCertificat(self, certificate: selectedCertificate)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "genreSegue" {
            let destination = segue.destination as! GenreController
            destination.delegate = self
            client.getGenre { (result) in
                switch result {
                case .success(let genres):
                    destination.genres = genres.genres
                    destination.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension CertificateController: GenreControllerDelegate {
    func selectedGenres(_ controller: GenreController, genres: [Int]) {
        delegate?.selectedGenre(self, genres: genres)
    }
    
    func selectedPeople(_ controller: GenreController, people: [Int]) {
        delegate?.selectedPeople(self, people: people)
    }
}
