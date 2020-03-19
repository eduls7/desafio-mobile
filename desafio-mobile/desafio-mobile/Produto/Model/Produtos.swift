//
//  Produtos.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 16/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import Foundation


struct Produto: Decodable {
    let size: Int
    let total: Int
    let products: [Products]
    
    enum CodingKeys: String, CodingKey {
        case size = "Size"
        case total = "Total"
        case products = "Products"
    }
    
}

struct Products: Decodable {
    let skus: [Skus]
    let name: String
    let id: String
    enum CodingKeys: String, CodingKey {
        case skus = "Skus"
        case name = "Name"
        case id = "Id"
    }
}

struct Skus: Decodable {
    let id: String
    let name: String
    let sellers: [Sellers]
    let images: [Images]
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case sellers = "Sellers"
        case images = "Images"

    }
}

struct Sellers: Decodable {
    let id: String
    let name: String
    let price: Double
    let listPrice: Double
    let bestInstallment: BestInstallment
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case price = "Price"
        case listPrice = "ListPrice"
        case bestInstallment = "BestInstallment"
    }
    
}

struct BestInstallment: Decodable {
   let count: Int
   let value, total: Double

   enum CodingKeys: String, CodingKey {
       case count = "Count"
       case value = "Value"
       case total = "Total"
   }
}

struct Images: Decodable {
    let imageUrl: String
    let imageTag: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "ImageUrl"
        case imageTag = "ImageTag"
    }
}

