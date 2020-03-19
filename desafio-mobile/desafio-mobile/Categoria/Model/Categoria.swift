//
//  Categoria.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 16/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import Foundation


// MARK: - Categoria
struct Categoria: Decodable {
    let categories: [Category]
    let id: Int

    enum CodingKeys: String, CodingKey {
        case categories = "Categories"
        case id = "Id"
    }
}

// MARK: - Category
struct Category: Decodable {
    let id: Int
    let name: String
    let subCategories: [Category]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case subCategories = "SubCategories"
    }
}
