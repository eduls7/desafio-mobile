//
//  ViewController.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 12/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate{


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var colecaoProdutos: UICollectionView!
    //var countProdutos = 10
    
    var produtos: [Products] = []
    var searchProdutos: [Products] = []
    var produtosTotal: [Products] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getProducts()
        self.searchBar.delegate = self
        self.colecaoProdutos.dataSource = self
        self.colecaoProdutos.delegate = self
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produtos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaProduto = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaProduto", for: indexPath) as! HomeCollectionViewCell
        
        let produto = produtos[indexPath.row]
        
        celulaProduto.configuraCelula(produto: produto)
        
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
