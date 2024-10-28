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
    
    lazy var navBackground: UIView = {
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
        btn.tintColor = .systemPink
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
      
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // background da view
            self.navBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBackground.topAnchor.constraint(equalTo: self.topAnchor),
            self.navBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    func setupStyles() {
        
    }
    
    
}
