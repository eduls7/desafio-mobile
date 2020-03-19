//
//  CategoriaViewController.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 17/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import UIKit
import Alamofire

class CategoriaViewController: UIViewController {

    @IBOutlet weak var tabelaCategoria: UITableView!
    var categorias: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelaCategoria.dataSource = self
        self.tabelaCategoria.delegate = self
        getCategorias()
    }
    
}

extension CategoriaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = categorias[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    
}

extension CategoriaViewController {
    func getCategorias() {
        
        let url = "https://desafio.mobfiq.com.br/StorePreference/CategoryTree"
        AF.request(url, method: .get).responseDecodable(of: Categoria.self) { (response) in
        switch response.result {
            case .success:
                if let jsonResponse = response.value  {
                    //self.categorias = jsonResponse.categories
                    //self.tabelaCategoria.reloadData()
                }
            break
            case .failure(let error):
                print(error)
            break
        }
      }
    }
}

