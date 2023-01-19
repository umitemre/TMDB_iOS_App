//
//  NowPlayingView.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 16.01.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HeaderSliderView: UICollectionReusableView {
    @IBOutlet weak var nowPlaying: UICollectionView!
    
    static let identifier = "HeaderSliderView"

    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.nowPlaying.register(UINib(nibName: "NowPlayingItem", bundle: nil), forCellWithReuseIdentifier: NowPlayingItem.identifier)
        
        self.nowPlaying.delegate = self
    }
    
    func bind(_ datam: [MovieResult]?) {
        guard let data = datam else {
            return
        }
        
        self.nowPlaying.dataSource = nil

        Observable.just(data)
            .bind(to: self.nowPlaying.rx.items(
                cellIdentifier: NowPlayingItem.identifier,
                cellType: NowPlayingItem.self
            )) { row, item, cell in
                cell.bind(item)
            }.disposed(by: disposeBag)
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
