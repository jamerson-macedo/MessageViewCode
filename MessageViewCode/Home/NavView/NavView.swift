//
//  NavView.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 28/10/24.
//

import UIKit

enum TypeConversationOrContact {
    case conversation
    case contact
}
protocol NavViewProtocol : AnyObject{
    func typeScreenMessage(_ type: TypeConversationOrContact)
}
class NavView: UIView {
    weak private var delegate : NavViewProtocol?
    
    func delegate(delegate : NavViewProtocol){
        self.delegate = delegate
    }
    
    lazy var navBackgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner] // apenas na parte direita
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    lazy var navBar : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var searchBar: UIView = {
        let searchBar = UIView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.clipsToBounds = true
        searchBar.backgroundColor = CustomColor.appLight
        searchBar.layer.cornerRadius = 20
        return searchBar
    }()
    
    
    lazy var searchLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName:"magnifyingglass"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    lazy var conversationBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName:"message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .systemPink
        btn.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
        return btn
    }()
    lazy var contactBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName:"person.3")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func tappedConversationButton(){
        self.delegate?.typeScreenMessage(.conversation)
        self.conversationBtn.tintColor = .systemPink
        self.contactBtn.tintColor = .black
    }
    @objc func tappedContactButton(){
        self.delegate?.typeScreenMessage(.contact)
        self.conversationBtn.tintColor = .black
        self.contactBtn.tintColor = .systemPink
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
extension NavView : ViewCode{
    func addSubviews() {
        self.addSubview(self.navBackgroundView)
        self.navBackgroundView.addSubview(self.navBar)
        self.navBar.addSubview(self.searchBar)
        self.navBar.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.conversationBtn)
        self.stackView.addArrangedSubview(self.contactBtn)
        self.searchBar.addSubview(self.searchLabel)
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
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor,constant: 30),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor,constant: -20),
            self.searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            self.stackView.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor,constant: -30),
            self.stackView.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 30),
            self.stackView.widthAnchor.constraint(equalToConstant: 100),
            
            self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor,constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.searchBtn.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            self.searchBtn.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.searchBtn.widthAnchor.constraint(equalToConstant: 20),
            self.searchBtn.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setupStyles() {
        
    }
    
    
}
