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
    @IBOutlet var upcomingList: UICollectionView!
        
    let viewModel = MainViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.upcomingList.register(UINib(nibName: "UpcomingListItem", bundle: nil), forCellWithReuseIdentifier: UpcomingListItem.identifier)

        self.upcomingList.register(UINib(nibName: "HeaderSliderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSliderView.identifier)

        upcomingList.delegate = self

        self.setObservers()
    }
    
    func setObservers() {
        viewModel.getUpcomingMovies()
        
        viewModel.upcomingMovies.catch { error in
            print("An error occured. Here look: \(error.localizedDescription)")
            return Observable.just([])
        }.bind(to: self.upcomingList.rx.items(
            cellIdentifier: UpcomingListItem.identifier,
            cellType: UpcomingListItem.self)
        ) { row, model, cell in
            cell.bind(model)
            cell.layer.addBorder(edge: .bottom, color: UIColor.dividerGray, thickness: 1.0)
        }.disposed(by: disposeBag)
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
}
