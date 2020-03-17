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
    let offset: Int
    let total: Int
    let delay: Double
    let products: [Products]
    let apiQuery: String
    
    enum CodingKeys: String, CodingKey {
        case size = "Size"
        case offset = "Offset"
        case total = "Total"
        case delay = "Delay"
        case products = "Products"
        case apiQuery = "ApiQuery"
    }
    
}

struct Products: Decodable {
   let availability: Bool
   let skus: [Skus]
   let name, id, brand, productDescription: String
   let category: String

   enum CodingKeys: String, CodingKey {
       case availability = "Availability"
       case skus = "Skus"
       case name = "Name"
       case id = "Id"
       case brand = "Brand"
       case productDescription = "Description"
       case category = "Category"

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
    let quantity: Int
    let price: Double
    let listPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case quantity = "Quantity"
        case price = "Price"
        case listPrice = "ListPrice"
    }
    
}

struct BestInstallment: Decodable {
   let count: Int
   let value, total: Double
   let rate: Int

   enum CodingKeys: String, CodingKey {
       case count = "Count"
       case value = "Value"
       case total = "Total"
       case rate = "Rate"
   }
}

enum Name: String, Decodable {
   case philips = "Philips"
   case polishop = "polishop"
}


struct Images: Decodable {
    let imageUrl: String
    let imageTag: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "ImageUrl"
        case imageTag = "ImageTag"
    }
}

