//
//  ViewController.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 13/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var person1Button: UIButton!
    @IBOutlet weak var person2Button: UIButton!
    
    let client = TmdbApiClient()
    
    var rating: Certificate?
    var genresId = [Int]()
    var peopleId = [Int]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        person2Button.isEnabled = false
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstPerson" || segue.identifier == "secondPerson" {
            let destination = segue.destination as! CertificateController
            destination.delegate = self
            client.getCertificate { (result) in
                switch result {
                case .success(let certificates):
                    let rating = certificates.certifications.US
                    let orderedCertificates = rating.sorted(by: { $0.order < $1.order })
                    destination.certificate = orderedCertificates
                    destination.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        } else if segue.identifier == "resultSegue" {
            let destination = segue.destination as! ResultController
            var totalPages = 0
            var currentPage = 0
            repeat {
                currentPage += 1
                client.getMovies(certificateCountry: "US", certificate: rating!.certification, page: "\(currentPage)", genres: getGenres(), people: getPeople()) { (result) in
                    switch result {
                    case .success(let movies):
                        destination.movies += movies.results
                        destination.tableView.reloadData()
                        totalPages = movies.totalPages
                    case .failure(let error):
                        print(error)
                    }
                }
            } while currentPage < totalPages
            
        }
    }
    
    // MARK: - Helper methods
    
    func getGenres() -> String {
        let strGenres = genresId.map({ String($0) })
        return strGenres.joined(separator: "|")
    }
    
    func getPeople() -> String {
        let strPeople = peopleId.map({ String($0) })
        return strPeople.joined(separator: "|")
    }

}

extension ViewController: CertificateControllerDelegate {
    func selectedCertificat(_ controller: CertificateController, certificate: Certificate) {
        if let rating = rating {
            if rating.order < certificate.order {
                self.rating = certificate
            }
        } else {
            self.rating = certificate
        }
    }
    
    func selectedGenre(_ controller: CertificateController, genres: [Int]) {
        for genre in genres {
            if !genresId.contains(genre) {
                genresId.append(genre)
            }
        }
        
    }
    
    func selectedPeople(_ controller: CertificateController, people: [Int]) {
        for personId in people {
            if !peopleId.contains(personId) {
                peopleId.append(personId)
            }
        }
        
        if person1Button.isEnabled {
            person1Button.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
            person1Button.isEnabled = false
            person2Button.isEnabled = true
        } else {
            person2Button.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
            person2Button.isEnabled = false
        }
    }
}
