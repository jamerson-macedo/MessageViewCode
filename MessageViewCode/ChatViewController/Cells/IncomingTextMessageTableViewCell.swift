//
//  IncomingTextMessageTableViewCell.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 11/11/24.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {
    
    static let identifier : String = "IncomingTextMessageTableViewCell"
    
    lazy var contactMessage : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.06)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMinYCorner]
        return view
    }()
    lazy var messageTextLabel : UILabel = {
       let msg = UILabel()
        msg.numberOfLines = 0
        msg.translatesAutoresizingMaskIntoConstraints = false
        msg.textColor = .darkGray
        msg.font = UIFont(name: CustomFont.poppinsMedium, size: 14)
        return msg
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("has not been implemented")
    }
    public func setupCell(message:Message?){
        self.messageTextLabel.text = message?.text
    }
   

}
extension IncomingTextMessageTableViewCell : ViewCode{
    func addSubviews() {
        self.addSubview(self.contactMessage)
        self.contactMessage.addSubview(messageTextLabel)
        self.isSelected = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.contactMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.contactMessage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.contactMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            self.messageTextLabel.leadingAnchor.constraint(equalTo: self.contactMessage.leadingAnchor,constant: 15),
            self.messageTextLabel.topAnchor.constraint(equalTo: self.contactMessage.topAnchor,constant: 15),
            self.messageTextLabel.bottomAnchor.constraint(equalTo: self.contactMessage.bottomAnchor,constant: -15),
            self.messageTextLabel.trailingAnchor.constraint(equalTo: self.contactMessage.trailingAnchor,constant: -15),
          
            
            
        ])
    }
    
    
    
}
