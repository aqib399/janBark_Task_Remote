//
//  APIService.swift
//  janBark Task
//
//  Created by Aqib Zareen on 21/01/2023.
//

import Foundation

class APIService :  NSObject {
    
    func getImages(pageUrl: String,comp : @escaping ([ImagesModel])->())  {
        
        let url = URL(string: pageUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("Bearer " + "563492ad6f917000010000015bd031e44c9744e987b52401da5fb889", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) {
            data, responce, error in
           if error != nil {
                return
            }
            do{
                let imagesData = try JSONDecoder().decode(ImagesModel.self, from: data!)
                for _ in 1 ... imagesData.photos.count{
                    items.append(contentsOf: [imagesData])

                }
                comp(items)
            }catch{
                print(error)
            }
        }.resume()
        
    }
    
}
