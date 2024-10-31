//
//  MessageDetailCollectionViewCell.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 29/10/24.
//

import UIKit
// MARK: Celula de lista de contatos e ultima mensagem
class MessageDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MessageDetailCollectionViewCell"
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 26
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    lazy var userName : UILabel = {
        let name : UILabel = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 2
        return name
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(userName)
        self.setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 55),
            self.imageView.widthAnchor.constraint(equalToConstant: 55),
            
            self.userName.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor,constant: 15),
            self.userName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.userName.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewContact(contact:Contact){
        self.setUserName(userName: contact.nome ?? "")
    }
    func setupViewConversation(conversation:Conversation){
        
    }
    func setUserName(userName:String){
        let attributText = NSMutableAttributedString(string: userName,attributes: [
            NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ])
        self.userName.attributedText = attributText
        
    }
    func setUserNameAtributedText(_ conversation : Conversation){
        let atributedText = NSMutableAttributedString(string: "\(conversation.name ?? "")", attributes: [
            NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        // adiciona o campo de ultima mensagem quebrando a linha
        atributedText.append(NSAttributedString(string: "\n\(conversation.lasMesage ?? "")", attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        self.userName.attributedText = atributedText
    }
}
