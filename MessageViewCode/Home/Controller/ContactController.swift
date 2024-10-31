//
//  ContactController.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 29/10/24.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContatoProtocol: AnyObject {
    func alertStateError(title : String, message : String)
    func sucessContato()
}
class ContactController {
    weak var delegate: ContatoProtocol?
    public func delegate(delegate : ContatoProtocol?){
        self.delegate = delegate
    }
    func addContact(email : String,emailUserLoged : String,idUsuario:String) {
        if email == emailUserLoged {
            self.delegate?.alertStateError(title: "voce adicionou o propio email", message: "Adicione um Email diferente")
            return
        }
        let firebase = Firestore.firestore()
        firebase.collection("users").whereField("email", isEqualTo: email).getDocuments { query, error in
            if let error = error {
                print("Erro ao procurar")
            }
            if let totalItens = query?.count{
                if totalItens == 0{
                    self.delegate?.alertStateError(title: "Usuario não cadastrado", message: "Verifique o Email e tente novamente")
                    return

                }
            }
            if let snapshot = query{
                for document in snapshot.documents{
                    let dados = document.data()
                    self.saveContact(dadosContact: dados, idUsuario: idUsuario)
                }
            }
        }
    }
    func saveContact(dadosContact: Dictionary<String,Any>,idUsuario:String){
        let contact: Contact = Contact(dict: dadosContact)
        let firestore = Firestore.firestore()
        firestore.collection("users").document(idUsuario).collection("contatos").document(contact.id ?? "").setData(dadosContact) { error in
            if error == nil{
                self.delegate?.sucessContato()
            }
        }
    }
}
