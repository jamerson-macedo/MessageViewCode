//
//  RegisterVC.swift
//  Login ViewCode
//
//  Created by Jamerson Macedo on 22/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class RegisterVC: UIViewController {
    var registerScreen : RegisterScreen?
    var auth : Auth?
    var firestore : Firestore?
    var alert : Alert?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
        self.firestore =  Firestore.firestore()
        
    }
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }

}
extension RegisterVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension RegisterVC : RegisterScreenProtocol{
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func actionRegisterButton() {
        guard let register = self.registerScreen else { return }
        self.auth?.createUser(withEmail:register.getEmail() , password: register.getPassWord(), completion: { result, error in
            if error != nil {
                self.alert?.getAlert(title: "Erro ao cadastrar", message: "Tente cadastrar novamente")
                print(error)
            }else {
                if let idUsuario = result?.user.uid {
                    self.firestore?.collection("users").document(idUsuario).setData([
                        "nome": register.getName(),
                        "email": register.getEmail(),
                        "id": idUsuario
                        
                    ])
                }
                
                
                self.alert?.getAlert(title: "Sucesso ao cadastrar", message: " sucesso",completion: {
                    self.navigationController?.popViewController(animated: true)
                })

                self.navigationController?.popViewController(animated: true)

                print("Sucesso")
            }
        })
    }
    
    
}
