//
//  ViewController.swift
//  Login ViewCode
//
//  Created by Jamerson Macedo on 16/10/24.
//

import UIKit
import FirebaseAuth
class LoginVC: UIViewController {
    
    var loginScreen : LoginScreen?
    var auth : Auth?
    var alert : Alert?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.configureTextFieldDelegate(delegate: self)
        self.loginScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
    }
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = loginScreen
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


}
extension LoginVC:LoginScreenProtocol{
    func actionLoginButton() {
        guard let login = self.loginScreen else { return }
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { result, error in
            if error != nil{
                self.alert?.getAlert(title: "Erro Firebase", message: "Dados incorretos")
            }else {
                self.alert?.getAlert(title: "Usuario Logado", message: "Parabéns",completion: {
                    let vc = HomeVC()
                    let navVc = UINavigationController(rootViewController: vc)
                    navVc.modalPresentationStyle = .fullScreen
                    self.present(navVc, animated: true)
                })
            }
        })
        
    }
    
    func actionRegisterButton() {
        let vc = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension LoginVC :UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // para fechar o textfield
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("bEGIN")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validateTextFields()
    }
}


