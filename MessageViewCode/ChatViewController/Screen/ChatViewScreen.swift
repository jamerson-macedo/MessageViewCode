//
//  ChatViewScreen.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 31/10/24.
//

import UIKit
import AVFoundation
class ChatViewScreen: UIView {
    
    var bottomConstraint : NSLayoutConstraint?
    var player : AVAudioPlayer?
    
    lazy var navView : ChatNavigationView = {
        let view = ChatNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageInputView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints =  false
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var messageBar : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints =  false
        view.backgroundColor = CustomColor.appLight
        view.layer.cornerRadius = 20
        
        return view
    }()
    lazy var sendBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints =  false
        btn.backgroundColor = CustomColor.appLight
        btn.layer.cornerRadius = 22
        btn.layer.shadowColor = CustomColor.appLight.cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(self.sendBtnPressed), for: .touchUpInside)
        btn.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return btn
    }()
    
    lazy var messageTextField : UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints =  false
        txt.placeholder = "Digite uma mensagem"
        txt.font  = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        txt.textColor = .darkGray
        
        return txt
    }()
    lazy var tableview : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints =  false
        table.backgroundColor = .clear
        table.transform = CGAffineTransform(scaleX: 1, y: 1)
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        return table
    }()
    public func configTableView(delegate : UITableViewDelegate,datasource : UITableViewDataSource){
        self.tableview.delegate = delegate
        self.tableview.dataSource = datasource
    }
    public func reloadTableView(){
        self.tableview.reloadData()
    }
    public func configNavView(controller : ChatViewController){
        self.navView.controller = controller
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(handlerKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil) // quando o telcado levantar
        NotificationCenter.default.addObserver(self, selector: #selector(handlerKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil) // abaixar
        self.messageTextField.addTarget(self, action: #selector(textfieldDidChange), for: UIControl.Event.editingChanged)
        
        self.bottomConstraint = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(bottomConstraint ?? NSLayoutConstraint())
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
        self.messageTextField.becomeFirstResponder() // para abaixar o teclado
    }
    @objc func sendBtnPressed(){
        // funcao para aumentar e diminuir
        self.sendBtn.touchAnimation(s: self.sendBtn)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
extension ChatViewScreen : ViewCode{
    func addSubviews() {
        self.addSubview(self.tableview)
        self.addSubview(self.navView)
        self.addSubview(messageInputView)
        self.messageInputView.addSubview(messageBar)
        self.messageBar.addSubview(sendBtn)
        self.messageBar.addSubview(self.messageInputView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140), // tamanho
            
            self.tableview.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            self.tableview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableview.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor),
            
            self.messageInputView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor), // foca em baixo
            self.messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            self.messageBar.leadingAnchor.constraint(equalTo: self.messageInputView.leadingAnchor,constant: 20),
            self.messageBar.trailingAnchor.constraint(equalTo: self.messageInputView.trailingAnchor,constant: -20),
            self.messageBar.heightAnchor.constraint(equalToConstant: 55),
            self.messageBar.centerYAnchor.constraint(equalTo: self.messageInputView.centerYAnchor),
            
            self.sendBtn.trailingAnchor.constraint(equalTo: self.messageBar.trailingAnchor,constant: -15),
            self.sendBtn.heightAnchor.constraint(equalToConstant: 55),
            self.sendBtn.widthAnchor.constraint(equalToConstant: 55),
            self.sendBtn.bottomAnchor.constraint(equalTo: self.messageBar.bottomAnchor,constant: -10),
            
            self.messageTextField.leadingAnchor.constraint(equalTo: self.messageBar.leadingAnchor,constant: 20),
            self.messageTextField.trailingAnchor.constraint(equalTo: self.sendBtn.trailingAnchor,constant: -5),
            self.messageTextField.heightAnchor.constraint(equalToConstant: 45),
            self.messageTextField.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor),
            
            
            
        ])
    }
    @objc func handlerKeyboardNotification(notification : Notification){
        if let keyboard : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRect : CGRect = keyboard.cgRectValue
            let keyboardHeight : CGFloat = keyboardRect.height
            // se estiver aberto
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableview.center.y = isKeyboardShowing ? self.tableview.center.y-keyboardHeight : self.tableview.center.y+keyboardHeight
            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut,animations: {
                self.layoutIfNeeded()
            }) { completed in
                // fazer algo
            }
        }
    }
    
}
extension ChatViewScreen  : UITextFieldDelegate{
    @objc func textfieldDidChange(_ textField : UITextField){
        if self.messageTextField.text == ""{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0,options:.curveEaseInOut, animations: {
                self.sendBtn.isEnabled = false
                self.sendBtn.layer.opacity = 0.3
                self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
            },completion: { _ in
                
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0,options:.curveEaseInOut, animations: {
                self.sendBtn.isEnabled = true
                self.sendBtn.layer.opacity = 1
                self.sendBtn.transform = .identity
                
            },completion: {_ in
                
            })
        }
    }
}
