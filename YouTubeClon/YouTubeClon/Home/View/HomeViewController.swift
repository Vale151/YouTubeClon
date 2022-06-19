//
//  HomeViewController.swift
//  YouTubeClon
//
//  Created by user on 05/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter = HomePresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


extension HomeViewController: HomeViewProtocol {
    func getData(list: [[Any]]) {
        print("list", list) //Cuando desde el presenter se llame  o return info la vamos a imprimir 
    }
}
