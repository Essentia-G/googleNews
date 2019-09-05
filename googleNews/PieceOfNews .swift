//
//  PieceOfNews .swift
//  googleNews
//
//  Created by Станислава on 18.08.2019.
//  Copyright © 2019 Stminchuk. All rights reserved.
//

import Foundation

struct PieceOfNews: Codable {
    var title: String
    var description: String
    var content: String
    var url: URL
    var urlToImage: URL
    //var publishedAt: Date
    
    
}
