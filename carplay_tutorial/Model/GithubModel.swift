//
//  GithubModel.swift
//  carplay_tutorial
//
//  Created by 小柳智之 on 2021/09/14.
//

import Foundation

struct GithubModel: Codable{
    let fullName: String
    var urlStr: String {"https://github.com/\(fullName)"}
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
    
//    required init (from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        fullName = try values.decode([Int].self, forKey: .fullName)
//    }
}

struct APIResponce: Codable {
    let items: [GithubModel]
}
