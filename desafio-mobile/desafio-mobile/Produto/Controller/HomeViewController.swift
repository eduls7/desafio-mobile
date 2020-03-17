//
//  ViewController.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 12/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tabela: UITableView!
    var produtos: [Products] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tabela.dataSource = self
        self.tabela.delegate = self
        getProducts()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let itemProduto = produtos[indexPath.row]
        cell.textLabel?.text = itemProduto.name
        
        return cell
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
                self.produtos = jsonResponse.products
                self.tabela.reloadData()
                print(jsonResponse.products[0].skus[0].images[0].imageUrl)
              }
              break
            case .failure(let error):
                print(error)
              break
            }
        }
    }
}













