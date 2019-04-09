//
//  MoviesViewController.swift
//  Flixter
//
//  Created by Ryan M on 4/4/19.
//  Copyright © 2019 Ryan M. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var moviesTableView: UITableView!
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        getMovies()
    }
    
    func getMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                //casting movies as array of dicts
                self.movies = dataDictionary["results"] as! [[String: Any]]
                print(self.movies)
                self.moviesTableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //gets called movies.count
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // if cell off screen, recycle it to save memory, if none can be recycled create new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let currMovie = movies[indexPath.row]
        
        //Swift optionals
        cell.titleLabel.text = currMovie["title"] as? String
        cell.summaryLabel.text = currMovie["overview"] as? String
        
        let size = "w185"
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/\(size)\(currMovie["poster_path"] as! String)")
        cell.posterImageView.af_setImage(withURL: posterUrl!)
        
        return cell
    }

}
