//
//  MainMoviesVC.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 10/05/2022.
//

import UIKit
import SDWebImage
import Toast_Swift

class MainMoviesVC: UIViewController {
    @IBOutlet weak var upcomingLbl: UILabel!
    @IBOutlet weak var mainscrollview: UIScrollView!
    @IBOutlet weak var topRatedLbl: UILabel!
    @IBOutlet weak var topratedCollectionV: UICollectionView!
    @IBOutlet weak var popularLbl: UILabel!
    @IBOutlet weak var popularCView: UICollectionView!
    @IBOutlet weak var upComingCVIew: UICollectionView!
    var topRated: [Movie]?
    var popular: [Movie]?
    var upcoming: [Movie]?
    
    var systemLanguage: NSString?
    
    var topRatedPageNum = 0
    var popularPageNum = 0
    var upcomingPageNum = 0
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        systemLanguage = Bundle.main.preferredLocalizations.first as NSString?
    }
    
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myscrolview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionV()
        setSettingsButton()
        setHomePageStrings()
        
        myscrolview.alwaysBounceVertical = true
        myscrolview.bounces = true
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        myscrolview.addSubview(refreshControl)
        
    }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        setMoviesLists(listType: "top_rated", page: topRatedPageNum)
        setMoviesLists(listType: "popular", page: popularPageNum)
        setMoviesLists(listType: "upcoming", page: upcomingPageNum)
        
        refreshControl.endRefreshing()

    }
    // MARK: - right bar button
    func setSettingsButton(){
        let menuBtn = UIButton(type: .custom)
            menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
            menuBtn.setImage(UIImage(named:"settings"), for: .normal)
        menuBtn.addTarget(self, action: #selector(settingsButtonAction), for: UIControl.Event.touchUpInside)

            let menuBarItem = UIBarButtonItem(customView: menuBtn)
            let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
            currWidth?.isActive = true
            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
            currHeight?.isActive = true
            self.navigationItem.rightBarButtonItem = menuBarItem
        
    }
    // MARK: - Homepage Strings
    func setHomePageStrings(){
        self.navigationItem.title = "Homepage".localized
        self.popularLbl.text = "Popular Movies".localized
        self.upcomingLbl .text = "Upcoming Movies".localized
        self.topRatedLbl .text = "Top Rated Movies".localized
    }
    // MARK: - delegete & DataSource
    func setCollectionV() {
        topratedCollectionV.delegate = self
        popularCView.delegate = self
        upComingCVIew.delegate = self
        popularCView.dataSource = self
        upComingCVIew.dataSource = self
        topratedCollectionV.dataSource = self

    }
    // MARK: - API Call
    func setMoviesLists(listType: String, page: Int = 1){
//        topratedCollectionV.isHidden = true
//        popularCView.isHidden = true
//        upComingCVIew.isHidden = true

        myActivityIndicator.startAnimating()
        
        let baseURL = "https://api.themoviedb.org/3/movie/"
        let apiKey = "80adae09b523d3037018900367438854"
        let imagebaseURL = "https://image.tmdb.org/t/p/w500/"
        
            MovieApi.shared.getHomeData(url:
            "\(baseURL)\(listType)?api_key=\(apiKey)&page=\(page)",completion: { Movies in
                print(Movies?.first)
                                
                var movieArra: [Movie] = Movies ?? []
                
                if movieArra.isEmpty{
                    self.view.makeToast("Please check your internet connection and try again", duration: 3.0, position: .bottom)
                                print("network is offff")
                    }
                var index = 0
                for movie in movieArra{
                    let newimageurl = imagebaseURL + (movie.posterPath ?? "")
                    let newBackImage = imagebaseURL + (movie.backdropPath ?? "")
                    movieArra[index].posterPath = newimageurl
                    movieArra[index].backdropPath = newBackImage
                    index += 1
                }
                if listType == "top_rated"{
                    if page != 1 {
                        self.topRated?.append(contentsOf: movieArra)
                    }else {
                        self.topRated = movieArra
//
                    }
                    self.topratedCollectionV.reloadData()
                }
                else if listType == "popular"{
                    if page != 1 {
                        self.popular?.append(contentsOf: movieArra)
                        
                    }else {
                        
                        self.popular = movieArra
                    }
                    self.popularCView.reloadData()

                }else if listType == "upcoming"{
                    if page != 1 {
                        self.upcoming?.append(contentsOf: movieArra)
                    }else {
                        self.upcoming = movieArra
                    }
                    self.upComingCVIew.reloadData()

                }
//
                if  self.popular?.count != 0{
                    print(movieArra.count)
                    self.myActivityIndicator.stopAnimating()
                    
//                    self.topratedCollectionV.isHidden = false
//                    self.popularCView.isHidden = false
//                    self.upComingCVIew.isHidden = false
                }else{
//                    print("no internet")
//
                }
            })
        
}
// MARK: - Top Right Button Action
@objc func settingsButtonAction(){
    let sb = UIStoryboard(name: "MoviesMain", bundle: nil)
    let vc = sb.instantiateViewController(identifier: "settingsvc") as? MovieSettingsVC ?? UIViewController()

    navigationController?.pushViewController(vc, animated: true)
    }
}

 // MARK: - Extensions
extension MainMoviesVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var listCount = 0
        if collectionView == topratedCollectionV {
            listCount = self.topRated?.count ?? 1
        }else if collectionView == popularCView {
            listCount = self.popular?.count ?? 1
        }
        else if collectionView == upComingCVIew {
            listCount = self.upcoming?.count ?? 1
        }
//        print(topRated?.first?.id)
        return listCount
    }
    // MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCVCell
        if collectionView == topratedCollectionV {
            let url = URL(string: topRated?[indexPath.row].posterPath ?? "" )
            cell.movImage?.sd_setImage(with: url, completed: nil)
        }else if collectionView == popularCView {
            let url = URL(string: popular?[indexPath.row].posterPath ?? "" )
            cell.movImage?.sd_setImage(with: url, completed: nil)
        }else if collectionView == upComingCVIew {
            let url = URL(string: upcoming?[indexPath.row].posterPath ?? "" )
            cell.movImage?.sd_setImage(with: url, completed: nil)
        }
        
        cell.movImage.layer.cornerRadius = 15
        cell.contentView.layer.shadowRadius = 1.0
        cell.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.contentView.layer.shadowOpacity = 1
        return cell
    }
    // MARK: - View Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }
    // MARK: - didSelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "MoviesMain", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "detailsvc") as? DetailsVC ?? UIViewController()
        if collectionView == topratedCollectionV {
            DetailsVC.movie = topRated?[indexPath.row]
        }else if collectionView == popularCView {
            DetailsVC.movie = popular?[indexPath.row]

        }else if collectionView == upComingCVIew {
            DetailsVC.movie = upcoming?[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    // MARK: - Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == topratedCollectionV {
            if topRatedPageNum < 3 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
                topRatedPageNum += 1
                setMoviesLists(listType: "top_rated", page: topRatedPageNum)
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
            }
        }else if collectionView == popularCView {
            if popularPageNum < 3 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
                popularPageNum += 1
                setMoviesLists(listType: "popular", page: popularPageNum)
            }
        }else if collectionView == upComingCVIew {
            if upcomingPageNum < 3 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
                upcomingPageNum += 1
                setMoviesLists(listType: "upcoming", page: upcomingPageNum)
            }
        }
        
    }
    
}
