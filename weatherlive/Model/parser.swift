//
//  parser.swift
//  weatherlive
//
//  Created by Yaroslav Zarechnyy on 9/17/18.
//  Copyright © 2018 Yaroslav Zarechnyy. All rights reserved.
//

import Foundation

typealias weather = [weatherElement]

struct weatherElement: Codable {
    let ccy, base_ccy, buy, sale: String
    
    enum CodingKeys: String, CodingKey {
       case ccy
        case base_ccy
        case buy
        case sale
    }
}
    
    
    class Parser {
        func requestData(completion: @escaping(weather?, Error?)->Void){
            let urlJsonFile = "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=6693034ff303434ab83815b1fd318ac9"
            guard let url = URL(string: urlJsonFile)
                else {return}
            URLSession.shared.dataTask(with: url){ (data:Data?,response: URLResponse?, error: Error?) in
                guard let data = data else {return}
            do{
                    let decoder = JSONDecoder()
                    let info = try? decoder.decode(weather.self, from: data)
                    if let elements = info {
                        completion(elements, nil)
                    }
                
                    else if error != nil{
                    completion(nil,error)
                    return
                }
            }
                catch {
                  completion(nil,error)
                }
                
            }.resume()
            
        }
        
}
