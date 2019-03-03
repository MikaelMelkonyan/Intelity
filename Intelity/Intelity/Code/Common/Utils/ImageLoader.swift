//
//  ImageLoader.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageLoader {
    
    static func load(by name: String, index: Int?, completion: @escaping ((String, Int?, UIImage?) -> ())) {
        guard let url = URL(string: Api.imageUrl + name + ".png") else {
            completion(name, index, nil)
            return
        }
        background {
            Alamofire.request(url).responseImage { response in
                main {
                    completion(name, index, response.result.value)
                }
            }
        }
    }
}
