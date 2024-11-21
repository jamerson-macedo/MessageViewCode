//
//  MessageAllModel.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 29/10/24.
//

import Foundation
struct Message{
    var text: String?
    var idUsuario: String?
    init(dict: [String: Any]){
        self.text = dict["text"] as? String
        self.idUsuario = dict["idUsuario"] as? String
    }
}
class Conversation{
    var name : String?
    var lastMesage: String?
    var idDestinatario:String?
    init(dict: [String: Any]){
        self.name = dict["nameUser"] as? String
        self.lastMesage = dict["lastMessage"] as? String
        self.idDestinatario = dict["idDestinatario"] as? String
    }
}
class User{
    var nome: String?
    var email: String?
    init(dict: [String: Any]?){
        self.nome = dict?["nome"] as? String
        self.email = dict?["email"] as? String
    }
   
}
class Contact{
    var id : String?
    var nome : String?
    init(dict: [String: Any]?){
        self.nome = dict?["nome"] as? String
        self.id = dict?["id"] as? String
    }
    // um iniciado alternativo
    convenience init (id: String?, nome: String?){
        self.init(dict: nil)
        self.nome = nome
        self.id = id
    }
}
