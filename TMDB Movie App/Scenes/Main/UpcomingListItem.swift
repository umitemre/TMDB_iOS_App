//
//  UpcomingListItem.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 15.01.2023.
//

import UIKit
import AlamofireImage

class UpcomingListItem: UICollectionViewCell {
    static let identifier = "UpcomingListItem"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(_ result: MovieResult) {
        if let posterPath = result.posterPath {
            moviePoster.layer.cornerRadius = 10
            moviePoster.layer.masksToBounds = true
            
            moviePoster.loadImageFromUrl("https://image.tmdb.org/t/p/w500\(posterPath)")
        }

        movieTitle.text = result.title
        movieDescription.text = result.overview
        movieReleaseDate.text = result.releaseDate.toAmericanShortDate()
    }
}
