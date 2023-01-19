//
//  NowPlayingItem.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 17.01.2023.
//

import UIKit

class NowPlayingItem: UICollectionViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!

    static let identifier = "NowPlayingItem"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ data: MovieResult) {
        if let backdropPath = data.backdropPath {
            moviePoster.loadImageFromUrl("https://image.tmdb.org/t/p/w500\(backdropPath)")
        }

        movieTitle.text = data.title
        movieDescription.text = data.overview
    }
}
