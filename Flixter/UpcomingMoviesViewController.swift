//
//  UpcomingMoviesViewController.swift
//  Flixter
//
//  Created by Ryan M on 4/21/19.
//  Copyright © 2019 Ryan M. All rights reserved.
//

import UIKit
import AlamofireImage

class UpcomingMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var moviesTableView: UITableView!
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        getMovies()
    }
    
    func getMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.moviesTableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingCell") as! UpcomingCell
        let currMovie = movies[indexPath.row]
        
        cell.titleLabel.text = currMovie["title"] as? String
        cell.summaryLabel.text = currMovie["overview"] as? String
        
        let size = "w185"
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/\(size)\(currMovie["poster_path"] as! String)")
        cell.posterVie.af_setImage(withURL: posterUrl!)
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //find selected movie
//        let clickedCell = sender as! UITableViewCell
//        let indexPath = moviesTableView.indexPath(for: clickedCell)!
//        let selectedMovie = movies[indexPath.row]
//
//        //pass movie to details vc
//        let detailsVC = segue.destination as! MovieDetailsViewControlelr
//        detailsVC.movie = selectedMovie
//
//        //deselect clicked cell
//        moviesTableView.deselectRow(at: indexPath, animated: true)
//    }

}
