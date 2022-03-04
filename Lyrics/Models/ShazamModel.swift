//
//  ShazamModel.swift
//  Lyrics
//
//  Created by Leandro Hernandez on 07/10/21.
//

import Foundation

struct ShazamModel : Decodable {
    let title: String?
    let artist : String?
    let album : URL?
}
