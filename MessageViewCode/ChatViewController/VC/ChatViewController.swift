//
//  ChatViewController.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 31/10/24.
//

import UIKit
import FirebaseFirestore

class ChatViewController: UIViewController {
    var screen : ChatViewScreen?
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    override func loadView() {
        self.screen = ChatViewScreen()
        self.view = screen
    }
    @objc func tappedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }

   

}
