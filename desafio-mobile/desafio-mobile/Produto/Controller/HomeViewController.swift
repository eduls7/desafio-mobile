//
//  ViewController.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 12/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching{


    @IBOutlet weak var searchProduto: UISearchBar!
    @IBOutlet weak var colecaoProdutos: UICollectionView!
    //var countProdutos = 10
    
    var produtos: [Products] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getProducts()
        searchProduto.delegate = self
        self.colecaoProdutos.dataSource = self
        self.colecaoProdutos.delegate = self
        self.colecaoProdutos.prefetchDataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
          getProducts()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produtos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaProduto = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaProduto", for: indexPath) as! HomeCollectionViewCell
        let produto = produtos[indexPath.row]
        
        
        celulaProduto.configuraCelula(produto: produto)
        
//        if isLoadingCell(for: indexPath) {
//          return celulaProduto
//        } else {
//            celulaProduto.nomeProduto.text = produto.name
//
//            celulaProduto.precoTabela.text = String("R$ \(produto.skus[0].sellers[0].listPrice)")
//            celulaProduto.precoFinal.text = String("R$ \(produto.skus[0].sellers[0].price)")
//            getImage(url: produto.skus[0].images[0].imageUrl, imageProduto: celulaProduto.imagemProduto)
//            celulaProduto.layer.borderWidth = 0.5
//            celulaProduto.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0,
//                                                    blue: 85.0/255.0, alpha: 1).cgColor
//        }
        
        return celulaProduto
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.height-220)/2, height: 400)
    }
}

extension HomeViewController {
    
    func getProducts() {
      let params: [String: Any] = [
        "Query": "",
        "Offset": 0,
        "Size": 10
      ]
        let url = "https://desafio.mobfiq.com.br/Search/Criteria"
        AF.request(url, method: .post, parameters: params).responseDecodable(of: Produto.self) { (response) in
            switch response.result {
            case .success:
              if let jsonResponse = response.value  {
                self.produtos.append(contentsOf: jsonResponse.products)
                //self.produtos = jsonResponse.products
                self.colecaoProdutos.reloadData()
                //self.countProdutos += 10
              }
              break
            case .failure(let error):
                print(error)
              break
            }
        }
    }
}

private extension HomeViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= 10
  }

  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleItems = colecaoProdutos.indexPathsForVisibleItems
    let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
