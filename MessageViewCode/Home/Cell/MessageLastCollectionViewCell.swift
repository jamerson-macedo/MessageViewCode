//
//  MessageLastCollectionViewCell.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 29/10/24.
//

import UIKit

class MessageLastCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "MessageLastCollectionViewCell"
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.image = UIImage(named: "person.badge.plus")
        return imageView
    }()
    lazy var userName : UILabel = {
        let name : UILabel = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Adicionar novo contato"
        name.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        name.textColor = .darkGray
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
    
    
}
