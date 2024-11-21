//
//  ChatViewController.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 31/10/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class ChatViewController: UIViewController {
    var screen : ChatViewScreen?
    var listaMensagens : [Message] = []
    var idUsuarioLogado : String?
    var contato : Contact?
    var mensagemListener : ListenerRegistration?
    var auth: Auth?
    var db: Firestore?
    var nomeContacto : String?
    var nomeUsuarioLogado : String?
    
    
     override func viewDidLoad() {
         super.viewDidLoad()
         self.configDataFirebase()
         self.configChatView()
         

       
     }
    override func viewWillAppear(_ animated: Bool) {
        self.addListenerRecuperarMensagens()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.mensagemListener?.remove()
    }
     override func loadView() {
         self.screen = ChatViewScreen()
         self.view = screen
     }
     @objc func tappedBackButton(){
         self.navigationController?.popViewController(animated: true)
     }
    private func configDataFirebase(){
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        
        //Recuperar Id Usuario Logado
        if let id = self.auth?.currentUser?.uid{
            self.idUsuarioLogado = id
            self.recuperarDadosUsuarioLogado()
        }
        
        if let nome = self.contato?.nome{
            self.nomeContacto = nome
        }
        
        
    }
    func addListenerRecuperarMensagens(){
        if let idDestinatario = self.contato?.id{
            self.mensagemListener = self.db?.collection("mensagens").document(self.idUsuarioLogado ?? "").collection(idDestinatario).order(by: "data",descending: true).addSnapshotListener({ query, error in
                // limpar tudo
                self.listaMensagens.removeAll()
                // recuperar
                if let snapshot = query{
                    for document in snapshot.documents{
                        let dados = document.data()
                        self.listaMensagens.append(Message(dict: dados))
                    }
                    self.screen?.reloadTableView()
                }
            })
            
        }
    }
    
    private func recuperarDadosUsuarioLogado(){
        let usuarios = self.db?.collection("users").document(self.idUsuarioLogado ?? "")
        usuarios?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let dados : Contact = Contact(dict: documentSnapshot?.data() ?? [:])
                self.nomeUsuarioLogado = dados.nome ?? ""
            }
        })
    }
    private func configChatView(){
        self.screen?.configNavView(controller: self)
        self.screen?.configTableView(delegate: self, dataSource: self)
        self.screen?.delegate(delegate: self)
    }
    private func salvarMensagem(idRemetente:String,idDestinatario : String,message:[String:Any]){
        self.db?.collection("mensagens").document(idRemetente).collection(idDestinatario).addDocument(data: message)
        // limpar o texto
        self.screen?.inputMessageTextField.text = ""
    }
    private func salvarConversa(idRemetente : String,idDestinatario:String, conversa:[String:Any]){
        self.db?.collection("conversas").document(idRemetente).collection("ultimas_conversas").document(idDestinatario).setData(conversa)

    }
    

}
extension ChatViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaMensagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let dados = self.listaMensagens[index]
        let idUsuario = dados.idUsuario ?? ""
        if self.idUsuarioLogado != idUsuario{
            // lado esquerdo
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier,for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: dados)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier,for: indexPath) as? OutgoingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: dados)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let desc : String = self.listaMensagens[indexPath.row].text ?? ""
        let font = UIFont(name: CustomFont.poppinsBold, size: 14) ?? UIFont()
        let estimateHeight = desc.heightWithConstrainedWidth(width: 220, font: font)
        return CGFloat(65 + estimateHeight)
    }
    
    
}
extension ChatViewController : ChatViewScreenProtocol{
    func actionPushMessage() {
        let message : String = self.screen?.inputMessageTextField.text ?? ""
        if let idUsuarioDestinatario  = self.contato?.id{
            let mensagem : Dictionary<String,Any> = [
                "idUsuario": self.idUsuarioLogado ?? "",
                "texto" : message,
                "data": FieldValue.serverTimestamp()
            ]
            // mensagem para remetente
            self.salvarMensagem(idRemetente: self.idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, message: mensagem)
            // mensagem para DESTINATARIO
            self.salvarMensagem(idRemetente: idUsuarioDestinatario, idDestinatario: self.idUsuarioLogado ?? "", message: mensagem)
            var conversa : [String:Any] = ["lastMessage": message]
            // salva a conversa para o remetente
            conversa["idRemetente"] = idUsuarioLogado ?? ""
            conversa["idDestinatario"] = idUsuarioDestinatario
            conversa["nameUser"] = self.nomeContacto ?? ""
            self.salvarConversa(idRemetente: idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, conversa: conversa)
            // salvar para destinatario
            conversa["idRemetente"] = idUsuarioDestinatario
            conversa["idDestinatario"] = idUsuarioLogado ?? ""
            conversa["nameUser"] = self.nomeUsuarioLogado
            self.salvarConversa(idRemetente: idUsuarioDestinatario, idDestinatario: idUsuarioLogado ?? "", conversa: conversa)
            
        }
    }
    
    
}
