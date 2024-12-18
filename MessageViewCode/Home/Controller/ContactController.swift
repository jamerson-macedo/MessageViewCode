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
    func addContact(email: String, emailUsuarioLogado: String, idUsuario: String) {
        
        if email == emailUsuarioLogado { // Verificar se está tentando adicionar você mesmo.
            self.delegate?.alertStateError(title: "Você adicionou seu próprio email.", message: "Adicione um email diferente.")
            return
        }
        
        // Verificar se existe o usuário no Firebase.
        // Verificando a coleção "usuarios" criada no Firebase onde armazena os dados dos usuários.
        let firestore = Firestore.firestore()
        firestore.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshotResultado, error in
            
            // Conta total de retorno - Quantidade de pessoas encontradas.
            if let totalItens = snapshotResultado?.count {
                // Se retornar 0, é porque não há usuário cadastrado.
                print("TOTAL ITENS: \(totalItens)")
                if totalItens == 0 {
                    self.delegate?.alertStateError(title: "Nenhum usuario Cadastrado.", message: "Verifique o email e tente novamente.")
                    return
                }
            }
            // Salvar contato se passar pela Validação de cima.
            if let snapshot = snapshotResultado {
                for document in snapshot.documents {
                    let dados = document.data() // Irá retornar um Array de Strings.
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
