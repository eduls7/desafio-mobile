//
//  ViewController.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 12/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var pesquisaProduto: UISearchBar!
    @IBOutlet weak var colecaoProdutos: UICollectionView!
    
    var produtos: [Products] = []
    //var image: String?
    //var jpg: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //print(produtos.count)
        
        getProducts()
        //pesquisaProduto.delegate = self
        self.colecaoProdutos.dataSource = self
        self.colecaoProdutos.delegate = self
//        image = produtos[0].skus[0].images[0].imageUrl
//        print(image!)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaProduto = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaProduto", for: indexPath) as! HomeCollectionViewCell
        let produto = produtos[indexPath.row]
        celulaProduto.nomeProduto.text = produto.name
        celulaProduto.precoTabela.text = String(produto.skus[0].sellers[0].listPrice)
        celulaProduto.precoFinal.text = String(produto.skus[0].sellers[0].price)
        getImage(url: produto.skus[0].images[0].imageUrl, imageProduto: celulaProduto.imagemProduto)
        celulaProduto.layer.borderWidth = 0.5
        celulaProduto.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0,
                                                  blue: 85.0/255.0, alpha: 1).cgColor
        
        
        return celulaProduto
    }
    
    func getImage (url: String, imageProduto: UIImageView)  {
        let downloader = ImageDownloader()
        let urlRequest = URLRequest(url: URL(string: url)!)

        downloader.download(urlRequest) { response in
            if case .success(let image) = response.result {
                imageProduto.image = image
            }
        }
    }
    
        
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.height-220)/2, height: 430)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
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
                self.produtos = jsonResponse.products
                self.colecaoProdutos.reloadData()
              }
              break
            case .failure(let error):
                print(error)
              break
            }
        }
        
        
    }
}

//extension HomeViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //searchText.rangeOfCharacter(from: searchText)
//    }
//}
