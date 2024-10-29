//
//  HomeVC.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 28/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class HomeVC: UIViewController {

    var homescreen: HomeScreen?
    var auth : Auth?
    var db : Firestore?
    var idUsuarioLogado: String?
    var screenContact :Bool?
    var emailLogedDoUser: String?
    var alert : Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
    
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        
    }
    override func loadView() {
        self.homescreen =  HomeScreen()
        self.view = self.homescreen
    }
    private func configHomeView(){
        self.homescreen?.navView.delegate(delegate: self)
    }
    private func configCollectionView(){
        self.homescreen?.delegateColletionView(delegate: self, datasource: self)
    }
    private func configAlert(){
        self.alert = Alert(controller: self)
    }
    

}
extension HomeVC: NavViewProtocol{
    func typeScreenMessage(_ type: TypeConversationOrContact) {
        switch type{
        case .contact:
            self.screenContact = true
        case .conversation:
            self.screenContact = false
        }
    }
    
    
}
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
}
