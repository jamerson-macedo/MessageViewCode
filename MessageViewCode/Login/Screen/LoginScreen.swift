//
//  myView.swift
//  Login ViewCode
//
//  Created by Jamerson Macedo on 16/10/24.
//

import UIKit

// quem conformar com esse objeto tem que ser uma classe
protocol LoginScreenProtocol : AnyObject{
    func actionLoginButton()
    func actionRegisterButton()
}
class LoginScreen: UIView {

    private lazy var  logoAppImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "google")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var emailTextField : UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu email"
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
    
        return textField
    }()
    private lazy var passwordTextField : UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Digite sua senha"
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default
        passwordTextField.backgroundColor = .white
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
    
        return passwordTextField
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true // ficar redondo
        button.layer.cornerRadius = 7.5 // corner radius
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(self.tappedLoginButton), for: .touchUpInside)
        return button
    }()
    lazy var registerButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Não tem conta ? registre-se", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)

        return button
    }()
    // para evitar retain cycle
    weak var delegate : LoginScreenProtocol?
    func delegate(delegate : LoginScreenProtocol?){
        self.delegate = delegate
    }
    init(){
        super.init(frame: .zero)// construtor do UIVIEW
        setup()
        self.configButtonEnable(enable: false)
    }
    @objc private func tappedLoginButton(){
        self.delegate?.actionLoginButton()
    }
    @objc private func tappedRegisterButton(){
        self.delegate?.actionRegisterButton()  }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
  
}
extension LoginScreen : ViewCode{
    func addSubviews() {
        addSubview(logoAppImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    func setupConstraints() {
        // de forma nativa
//        NSLayoutConstraint.activate([
//            logoAppImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
//            logoAppImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            emailTextField.topAnchor.constraint(equalTo: self.logoAppImageView.bottomAnchor,constant: 20),
//            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
//            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
//            
//            passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor,constant: 20),
//            
//            passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
//            passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
//            
//            self.emailTextField.heightAnchor.constraint(equalToConstant: 40),
//            self.passwordTextField.heightAnchor.constraint(equalToConstant: 40),
//            
//            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor,constant: 15),
//            self.loginButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
//            self.loginButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
//            
//            self.registerButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor,constant: 15),
//            self.registerButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
//            self.registerButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor)

            
            
//        ])
        // usando snapkit
        self.configLoginLabelConstraint()
        self.configEmailTextFieldConstraint()
        self.configPasswordTextFieldConstraint()
        self.configButtonLoginConstraint()
        self.configButtonRegisterConstraint()
    }
    func configLoginLabelConstraint(){
        self.logoAppImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    func configEmailTextFieldConstraint(){
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.logoAppImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }

    func configPasswordTextFieldConstraint(){
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(20)
            make.leading.equalTo(self.emailTextField.snp.leading)
            make.trailing.equalTo(self.emailTextField.snp.trailing)
            make.height.equalTo(45)
        }
    }
    func configButtonLoginConstraint(){
        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    func configButtonRegisterConstraint(){
        self.registerButton.snp.makeConstraints { make in
            make.top.equalTo(self.loginButton.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    func setupStyles() {
        backgroundColor = .white
    }
    public func configureTextFieldDelegate(delegate : UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    public func validateTextFields(){
        let email : String = self.emailTextField.text ?? ""
        let password : String = self.passwordTextField.text ?? ""
        if !email.isEmpty && !password.isEmpty {
            self.configButtonEnable(enable: true)
        }else {
            self.configButtonEnable(enable: false)
        }
    }
    private func configButtonEnable(enable : Bool){
        if enable{
            self.loginButton.setTitleColor(.white, for: .normal)
            self.loginButton.isEnabled = true
        }else {
            self.loginButton.setTitleColor(.lightGray, for: .normal)
            self.loginButton.isEnabled = false
        }
    }
    public func getEmail() ->String{
        return self.emailTextField.text ?? ""
    }
    public func getPassword() ->String{
        return self.passwordTextField.text ?? ""
    }
    
    
}
