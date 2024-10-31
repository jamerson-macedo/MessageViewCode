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
    var contato : ContactController?
    
    var contactList : [Contact] = []
    var conversationLIst : [Conversation] = []
    var conversasListenner : ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
       
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.addListenerRecoveryConversation()
        
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
    private func configIdentifierFirebase(){
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        // recuperar id
        if let currentUser = self.auth?.currentUser{
            self.idUsuarioLogado = currentUser.uid
            self.emailLogedDoUser = currentUser.email
        }
    }
    private func configContact(){
        self.contato = ContactController()
        self.contato?.delegate(delegate: self)
    }
    func addListenerRecoveryConversation(){
        if let IdUserLogado = auth?.currentUser?.uid{
            self.conversasListenner = db?.collection("conversas").document(IdUserLogado).collection("last_conversations").addSnapshotListener({ snapshot, error in
                if error == nil{
                    self.contactList.removeAll()
                    if let snapshot = snapshot{
                        for document in snapshot.documents{
                            let data = document.data()
                            self.contactList.append(Contact(dict: data))
                        }
                        self.homescreen?.reloadCollectionView()
                    }
                }
            })
        }
    }
    func getContact(){
        self.contactList.removeAll()
        self.db?.collection("users").document(self.idUsuarioLogado ?? "").collection("contatos").getDocuments(completion: { snapshot, error in
            if error != nil{
                print("erro ao buscar o contato")
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    self.contactList.append(Contact(dict: data))
                }
                self.homescreen?.reloadCollectionView()
            }
            
        })
    }
    
    
    

}
extension HomeVC: NavViewProtocol{
    func typeScreenMessage(_ type: TypeConversationOrContact) {
        switch type{
        case .contact:
            self.screenContact = true
            self.getContact()
        case .conversation:
            self.screenContact = false
            self.addListenerRecoveryConversation()
            self.homescreen?.reloadCollectionView()
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
extension HomeVC : ContatoProtocol{
    func alertStateError(title: String, message: String) {
        self.alert?.getAlert(title: title, message: message)
    }
    
    func sucessContato() {
        self.alert?.getAlert(title: "Parabéns !", message: "Usuario cadastrado com sucesso", completion: {
            self.getContact()
        })
    }
    
    
}
