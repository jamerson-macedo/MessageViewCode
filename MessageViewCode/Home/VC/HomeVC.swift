//
//  HomeVC.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 28/10/24.
//

import UIKit

class HomeVC: UIViewController {

    var homescreen: HomeScreen?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func loadView() {
        self.homescreen =  HomeScreen()
        self.view = self.homescreen
    }
    

}
