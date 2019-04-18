//
//  MovieDetailsViewControlelr.swift
//  Flixter
//
//  Created by Ryan M on 4/17/19.
//  Copyright © 2019 Ryan M. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewControlelr: UIViewController {
    
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        summaryLabel.text = movie["overview"] as? String
        summaryLabel.sizeToFit()
        
        let size = "w185"
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/\(size)\(movie["poster_path"] as! String)")
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropSize = "w780"
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/\(backdropSize)\(movie["backdrop_path"] as! String)")
        backDropView.af_setImage(withURL: backdropUrl!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
