//
//  HomeCollectionViewCell.swift
//  desafio-mobile
//
//  Created by Eduardo Jr on 17/03/20.
//  Copyright © 2020 Eduardo Jr. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagemProduto: UIImageView!
    @IBOutlet weak var nomeProduto: UILabel!
    @IBOutlet weak var precoTabela: UILabel!
    @IBOutlet weak var precoFinal: UILabel!
    @IBOutlet weak var parcelamento: UILabel!
    @IBOutlet weak var desconto: UILabel!
    
    func configuraCelula (produto: Products){
        let precoTab = produto.skus[0].sellers[0].listPrice
        let precoFin = produto.skus[0].sellers[0].price
        let parcelas = produto.skus[0].sellers[0].bestInstallment.count
        let valorParcela = produto.skus[0].sellers[0].bestInstallment.value
        
        if parcelas != 0 && valorParcela != 0 {
            parcelamento.text = "\(parcelas)x de \(valorParcela)"
        }
        nomeProduto.text = produto.name
        precoTabela.text = String(format:"R$%.02f", precoTab)
        precoFinal.text = String(format:"R$%.02f", precoFin)
        getImage(url: produto.skus[0].images[0].imageUrl, imageProduto: imagemProduto)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1).cgColor
        if precoTab != precoFin {
            precoTabela.text = String(format:"R$ %.02f", precoTabela)
            precoFinal.text = String(format:"R$ %.02f", precoFinal)
            let descontoOff = desconto(precoFinal: precoFin, precoTabela: precoTab)
            desconto.text = String("\(Int(descontoOff.rounded()))% OFF")
            desconto.textColor = .green
            precoTabela.textColor = .red
            precoFinal.textColor = .green
            precoTabela.isHidden = false
            desconto.isHidden = false
        }else{
            precoTabela.isHidden = true
            desconto.isHidden = true
            precoFinal.textColor = .black
        }
    }
    
    func desconto (precoFinal: Double, precoTabela: Double) -> Double {
        let desconto = 100 * ((precoTabela - precoFinal)/precoTabela)
        
        return desconto
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
