//
//  NowPlayingView.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 16.01.2023.
//

import UIKit

class HeaderSliderView: UICollectionReusableView {
    @IBOutlet weak var nowPlaying: UICollectionView!
    
    static let identifier = "HeaderSliderView"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.nowPlaying.register(UINib(nibName: "NowPlayingItem", bundle: nil), forCellWithReuseIdentifier: NowPlayingItem.identifier)
        
        self.nowPlaying.dataSource = self
        self.nowPlaying.delegate = self
    }
    
    func bind(_ data: [MovieResult]) {
        
    }
}

extension HeaderSliderView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.nowPlaying.dequeueReusableCell(withReuseIdentifier: NowPlayingItem.identifier, for: indexPath) as! NowPlayingItem
        
        return cell
    }
}

extension HeaderSliderView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
