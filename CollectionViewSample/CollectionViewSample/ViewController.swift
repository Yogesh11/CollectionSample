//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by Yogesh on 10/4/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import SVProgressHUD
import UIScrollView_InfiniteScroll

class ViewController: UIViewController {
    let movieViewModel : MovieViewModel = MovieViewModel()
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(pullToRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
    }()

    /** setup for infinite scroll */
    private func loadMoreSetup() {
        collectionView.addInfiniteScroll { (collectionV) in
             self.loadData(number: (self.movieViewModel.currentPage + 1))
             self.collectionView.finishInfiniteScroll()
        }
    }

    /** When user swipe down then below function will call and fetch first batch data from remote*/
    @objc private func pullToRefresh(_ refreshControl: UIRefreshControl){
        loadData(number: 1)
        refreshControl.endRefreshing()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate              = self
        collectionView.dataSource            = self
        collectionView?.backgroundColor      = .purple
        collectionView.refreshControl        = refreshControl
       // flowLayout?.estimatedItemSize        = CGSize(width: 50, height: 50)
       // flowLayout?.itemSize                 = UICollectionViewFlowLayout.automaticSize
        loadMoreSetup()
         loadData(number: 1)
        SVProgressHUD.setDefaultMaskType(.clear)
    }

    private func loadData(number : Int) {
        movieViewModel.currentPage = number
        SVProgressHUD.show()
        movieViewModel.getData() { (json, error) in
            if let err = error {
                Utility.showAlert(error: err)
            } else{
                self.collectionView.reloadData()
            }
            SVProgressHUD.dismiss()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.movie = movieViewModel.movieModels[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.movieModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let collectionViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionCell
        collectionViewCell?.displayContent(movie: movieViewModel.movieModels[indexPath.row])
        collectionViewCell?.backgroundColor = .red
        return collectionViewCell!
    }
}

