//
//  WeatherApi.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class WeatherApi: Api {
    
    func getWeather(by cityIds: [String], completion: @escaping ((Response<[JSON]>) -> ())) {
        guard !cityIds.isEmpty else {
            let message = "City IDs is empty"
            completion(.error(message))
            fatalError(message)
        }
        let method = "group"
        let parameters: Parameters = [
            "id": cityIds.joined(separator: ","),
            "units": super.units,
            "appid": super.apiKey
        ]
        
        let request = Alamofire.request(super.globalUrl + method, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        request.responseJSON { apiResponse in
            switch apiResponse.result {
            case let .success(value):
                let json = JSON(value)
                if let list = json["list"].array {
                    completion(.success(list))
                } else {
                    let error = json["message"].string ?? super.somethingWentWrongMessage
                    completion(.error(error))
                }
            case .failure:
                completion(.error(super.somethingWentWrongMessage))
            }
        }
    }
}
