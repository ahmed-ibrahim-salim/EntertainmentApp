//
//  MovieApiService.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 10/05/2022.
//

import Foundation
import Alamofire

class MovieApi {
    static let shared = MovieApi()
    
    func getHomeData(url: String, completion: @escaping([Movie]?)-> Void){
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request("\(url)", method: .get,headers: headers).responseData{ (dataResponse) in
            if dataResponse.data == nil{
                    completion([])
                }
            guard (dataResponse.data != nil),dataResponse.response?.statusCode == 200,
                  let data = dataResponse.data,
                  let model = Coder().decode(toType: MoviesModel.self, from: data)
//                  let dataModel = model.results
            else{
                return
            }
            completion(model.results)
//
        }
    }
    
    func getTrailerVideo(url: String, completion: @escaping([Result]?)-> Void){
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(url)", method: .get,headers: headers).responseData{ (dataResponse) in
                
                guard (dataResponse.data != nil),dataResponse.response?.statusCode == 200,
                      let data = dataResponse.data,
                      let model = Coder().decode(toType: TrailerModel.self, from: data),
                      let dataModel = model.results
                else{
                    return
                }
                completion(dataModel)
            }
        }
    
}
