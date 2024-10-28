//
//  RegisterScreen.swift
//  Login ViewCode
//
//  Created by Jamerson Macedo on 22/10/24.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}
class RegisterScreen:UIView {
    
    weak private var delegate : RegisterScreenProtocol?
    
    func delegate(delegate : RegisterScreenProtocol?){
        self.delegate = delegate
    }
    lazy var backButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    lazy var image : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "google")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    lazy var nameTextField : UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        tf.placeholder = "Nome"
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    lazy var emailTextField : UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    lazy var passwordTextField : UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.keyboardType = .default
        tf.placeholder = "Senha"
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.textColor = .darkGray
        return tf
    }()
    lazy var registerButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
    
        return button
    }()
    init(){
        super.init(frame: .zero)
        setup()
        self.configButtonEnable(enable: false)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RegisterScreen : ViewCode {
    func addSubviews() {
        addSubview(image)
        addSubview(backButton)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
    }
    
    func setupConstraints() {
        //        NSLayoutConstraint.activate([
        //            // image
        ////            self.image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
        ////            self.image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ////            self.image.widthAnchor.constraint(equalToConstant: 150),
        ////            self.image.heightAnchor.constraint(equalToConstant: 150),
        //            // button
        ////            self.backButton.topAnchor.constraint(equalTo: self.image.topAnchor),
        ////            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
        //            // emailfield
        ////            self.emailTextField.topAnchor.constraint(equalTo: self.image.bottomAnchor,constant: 20),
        ////            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
        ////            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
        ////            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
        //            // passwordField
        //            self.passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 15),
        //            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
        //            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
        //            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
        //// button
        //            self.registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 15),
        //            self.registerButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
        //            self.registerButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
        //            self.registerButton.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
        //
        //        ])
        //    }
        //    self.image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
        //    self.image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        //    self.image.widthAnchor.constraint(equalToConstant: 150),
        //    self.image.heightAnchor.constraint(equalToConstant: 150),
        self.configImageLogoConstraint()
        self.configBackButtonConstraint()
        self.configEmailTextFieldConstraint()
        self.configPasswordTextFieldConstraint()
        self.configButtonRegisterConstraint()
        self.configNameTextFieldConstraint()
    }
    func configImageLogoConstraint() {
        self.image.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }
    
    func configBackButtonConstraint() {
        self.backButton.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
    }
    func configNameTextFieldConstraint() {
        self.nameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }

    func configEmailTextFieldConstraint() {
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.nameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    func configPasswordTextFieldConstraint() {
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    func configButtonRegisterConstraint() {
        self.registerButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
            make.leading.equalTo(self.emailTextField.snp.leading)
            make.trailing.equalTo(self.emailTextField.snp.trailing)
            make.height.equalTo(self.emailTextField.snp.height)
        }
    }
    public func getEmail()->String{
        return self.emailTextField.text ?? ""
    }
    public func getPassWord()->String{
        return self.passwordTextField.text ?? ""
    }
    public func getName()->String{
        return self.nameTextField.text ?? ""
    }
    func setupStyles() {
        self.backgroundColor = .white
    }
    // para poder abaixar o teclado
    public func configTextFieldDelegate(delegate : UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
        self.nameTextField.delegate = delegate
    }
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    @objc private func tappedRegisterButton(){
        self.delegate?.actionRegisterButton()
    }
    public func validateTextFields(){
        let name :String = self.nameTextField.text ?? ""
        let email : String = self.emailTextField.text ?? ""
        let password : String = self.passwordTextField.text ?? ""
        if !email.isEmpty && !password.isEmpty && !name.isEmpty {
            self.configButtonEnable(enable: true)
        }else {
            self.configButtonEnable(enable: false)
        }
    }
    private func configButtonEnable(enable : Bool){
        if enable{
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        }else {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        }
    }
    
    
}
