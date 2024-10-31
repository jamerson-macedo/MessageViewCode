//
//  ChatNavigationView.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 31/10/24.
//

import UIKit

class ChatNavigationView: UIView {
    // toda vez que clicar tem que chamar uma acao no controler
    var controller : ChatViewController?{
        didSet{
            self.backBtn.addTarget(controller, action: #selector(ChatViewController.tappedBackButton), for: .touchUpInside)
        }
        
    }
    
    // tipo a toolbar
    lazy var navBackgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner] // apenas na parte direita
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        
        return view
    }()
    // tipo um quadrado com tudo
    lazy var navBar : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    // tipo um campo redondo com background diferente
    lazy var searchBar: UIView = {
        let searchBar = UIView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.clipsToBounds = true
        searchBar.backgroundColor = CustomColor.appLight
        searchBar.layer.cornerRadius = 20
        return searchBar
    }()
    
    // nome que vai ta dentro do background search
    lazy var searchLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        return label
    }()
    // botao dentro do search
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName:"magnifyingglass"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    // botao de voltar
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName:"arrow.left"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    //image
    lazy var customImage : UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 26
        image.clipsToBounds = true
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ChatNavigationView : ViewCode{
    func addSubviews() {
        self.addSubview(self.navBackgroundView)
        self.navBackgroundView.addSubview(self.navBar)
        self.navBar.addSubview(self.backBtn)
        self.navBar.addSubview(self.customImage)
        self.navBar.addSubview(self.searchBar)
        self.searchBar.addSubview(self.searchBtn)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // background da view é tudo
            self.navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            // navbar
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.backBtn.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor,constant: 30),
            self.backBtn.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor), // CENTRALIZADO AO MEIO
            self.backBtn.heightAnchor.constraint(equalToConstant: 30), // altura
            self.backBtn.widthAnchor.constraint(equalToConstant: 30), // largura
            
            self.customImage.leadingAnchor.constraint(equalTo: self.backBtn.trailingAnchor,constant: 20),
            self.customImage.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.customImage.widthAnchor.constraint(equalToConstant: 55),
            self.customImage.heightAnchor.constraint(equalToConstant: 55),
            
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.customImage.trailingAnchor,constant: 20),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor,constant: -20),
            self.searchBar.widthAnchor.constraint(equalToConstant: 55),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            
            self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.searchBtn.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            self.searchBtn.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.searchBtn.widthAnchor.constraint(equalToConstant: 20),
            self.searchBtn.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
}
