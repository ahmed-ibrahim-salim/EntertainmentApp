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
    
    var topRated: [Movie]?{
        didSet{
            categoriesTableV.reloadData()
        }
    }
    var popular: [Movie]?{
        didSet{
            categoriesTableV.reloadData()
        }
    }
    var upcoming: [Movie]?{
        didSet{
            categoriesTableV.reloadData()
        }
    }
    
    var systemLanguage: String?
    
    @IBOutlet weak var categoriesTableV: UITableView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        systemLanguage = Locale.preferredLanguages[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSettingsButton()
        setDelegates()
        setMoviesLists(listType: "top_rated")
        setMoviesLists(listType: "upcoming")
        setMoviesLists(listType: "popular")


        
    }

    // MARK: - Delegates
    func setDelegates(){
        categoriesTableV.delegate = self
        categoriesTableV.dataSource = self
        categoriesTableV.register(UINib(nibName: "CategoryTableVCell", bundle: nil), forCellReuseIdentifier: "CategoryTableVCell")
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
    
    // MARK: - API Call
    func setMoviesLists(listType: String, page: Int = 1){
        myActivityIndicator.startAnimating()
        
        let baseURL = "https://api.themoviedb.org/3/movie/"
        let apiKey = "80adae09b523d3037018900367438854"
        let imagebaseURL = "https://image.tmdb.org/t/p/w500/"
        
        MovieApi.shared.getHomeData(url: "\(baseURL)\(listType)?api_key=\(apiKey)&page=\(page)",completion: { Movies in
            
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
                //                    self.topratedCollectionV.reloadData()
            }
            else if listType == "popular"{
                if page != 1 {
                    self.popular?.append(contentsOf: movieArra)
                    
                }else {
                    
                    self.popular = movieArra
                }
                //                    self.popularCView.reloadData()
                
            }else if listType == "upcoming"{
                if page != 1 {
                    self.upcoming?.append(contentsOf: movieArra)
                }else {
                    self.upcoming = movieArra
                }
                //                    self.upComingCVIew.reloadData()
                
            }
            //
            if  self.popular?.count != 0{
                print(movieArra.count)
                self.myActivityIndicator.stopAnimating()
                
            }else{
                //                    print("no internet")
                //
            }
        }
        )
        
    }
    // MARK: - Top Right Button Action
    @objc func settingsButtonAction(){
        let sb = UIStoryboard(name: "MoviesMain", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "settingsvc") as? MovieSettingsVC ?? UIViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainMoviesVC:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableVCell") as? CategoryTableVCell else{ fatalError()}
        if indexPath.section == 0{
            cell.configureCell(data: topRated)
        }else if indexPath.section == 1{
            cell.configureCell(data: popular)
        }else{
            cell.configureCell(data: upcoming)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Top rated"
        }else if section == 1{
            return "Popular"
        }else{
            return "upcoming"
        }
    }
}
