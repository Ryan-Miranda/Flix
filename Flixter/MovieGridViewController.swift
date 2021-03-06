//
//  MovieGridViewController.swift
//  Flixter
//
//  Created by Ryan M on 4/17/19.
//  Copyright © 2019 Ryan M. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //spaces bw rows
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        //width of the phone but subtract the two space bw posters per row
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2)/3
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        getSimilarMovies()
    }
    
    func getSimilarMovies(){
        //Shazam's ID for "superhero" films
        let similarMovieID = 287947
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(similarMovieID)/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let currMovie = movies[indexPath.item]
        
        let size = "w185"
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/\(size)\(currMovie["poster_path"] as! String)")
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find selected movie
        let clickedCell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: clickedCell)!
        let selectedMovie = movies[indexPath.row]
        
        //pass movie to details vc
        let detailsVC = segue.destination as! CollectionDetailsViewController
        detailsVC.movie = selectedMovie
    }

}
