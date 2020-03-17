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
    let redirect: Redirect
    let subCategories: [Category]?
    let highlight: Bool
    let icon: String?
    let categoryListOrder, categoryTreeOrder, linkID: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case redirect = "Redirect"
        case subCategories = "SubCategories"
        case highlight = "Highlight"
        case icon = "Icon"
        case categoryListOrder = "CategoryListOrder"
        case categoryTreeOrder = "CategoryTreeOrder"
        case linkID = "LinkId"
    }
}

// MARK: - Redirect
struct Redirect: Decodable {
    let id: Int
    let searchCriteria: SearchCriteria
    let title: String
    let type: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case searchCriteria = "SearchCriteria"
        case title = "Title"
        case type = "Type"
    }
}

// MARK: - SearchCriteria
struct SearchCriteria: Decodable {
    let orderBy: Int
    let size, offset: Int?
    let apiQuery: String
    let searchAPI: SearchAPI?

    enum CodingKeys: String, CodingKey {
        case orderBy = "OrderBy"
        case size = "Size"
        case offset = "Offset"
        case apiQuery = "ApiQuery"
        case searchAPI = "SearchApi"
    }
}

enum SearchAPI: String, Decodable {
    case base = "base"
}


