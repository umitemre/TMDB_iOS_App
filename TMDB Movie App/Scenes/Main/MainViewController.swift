//
//  MainPageViewController.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 14.01.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
    @IBOutlet var mainPageMovieListCollectionView: UICollectionView!
        
    let viewModel = MainViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainPageMovieListCollectionView.register(UINib(nibName: "UpcomingListItem", bundle: nil), forCellWithReuseIdentifier: UpcomingListItem.identifier)

        self.mainPageMovieListCollectionView.register(UINib(nibName: "HeaderSliderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSliderView.identifier)

        mainPageMovieListCollectionView.delegate = self

        self.setObservers()
    }
    
    func setObservers() {
        viewModel.getMainPageMovieList()

        let dataSource = RxCollectionViewSectionedReloadDataSource<MainPageModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingListItem.identifier, for: indexPath) as! UpcomingListItem

                cell.bind(item)
                cell.layer.addBorder(edge: .bottom, color: UIColor.dividerGray, thickness: 1.0)

                return cell
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                switch(kind) {
                case UICollectionView.elementKindSectionHeader:
                    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSliderView.identifier, for: indexPath) as! HeaderSliderView

                    cell.bind(dataSource.sectionModels[0].nowPlaying)
                    
                    return cell
                default:
                    fatalError("Unknown type of kind provided.")
                }
            }
        )

        viewModel.mainPageMovieList
            .catch { error in
                print("An error occured. Here look: \(error.localizedDescription)")
                return Observable.just([])
            }
            .bind(to: self.mainPageMovieListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        // Ratio should be 45:32
        // If width    45
        //    _____ ==
        //    height   32
        
        // width * 32 = height * 45
        // height = width * 32 / 45

        let height = view.frame.size.width * 32 / 45
        return CGSize(width: view.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        switch(elementKind) {
        case UICollectionView.elementKindSectionHeader:
            let cell = view as! HeaderSliderView
            cell.restoreScrollPosition(viewModel.nowPlayingScrollState)
        default:
            fatalError("Unknown type of kind provided")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        switch(elementKind) {
        case UICollectionView.elementKindSectionHeader:
            let cell = view as! HeaderSliderView

            // Store the current position
            viewModel.nowPlayingScrollState = cell.nowPlaying.contentOffset
        default:
            fatalError("Unknown type of kind provided")
        }
    }
}
