//
//  OutgoingTextMessageTableViewCell.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 11/11/24.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {

    static let identifier : String = "OutgoingTextMessageTableViewCell"
    
    lazy var MYMessageView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appPurple
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return view
    }()
    lazy var messageTextLabel : UILabel = {
       let msg = UILabel()
            msg.translatesAutoresizingMaskIntoConstraints = false
        msg.numberOfLines = 0
        msg.textColor = .darkGray
        msg.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
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
extension OutgoingTextMessageTableViewCell : ViewCode{
    func addSubviews() {
        self.addSubview(self.MYMessageView)
        self.MYMessageView.addSubview(messageTextLabel)
        self.isSelected = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.MYMessageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.MYMessageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.MYMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            self.messageTextLabel.leadingAnchor.constraint(equalTo: self.MYMessageView.leadingAnchor,constant: 15),
            self.messageTextLabel.topAnchor.constraint(equalTo: self.MYMessageView.topAnchor,constant: 15),
            self.messageTextLabel.bottomAnchor.constraint(equalTo: self.MYMessageView.bottomAnchor,constant: -15),
            self.messageTextLabel.trailingAnchor.constraint(equalTo: self.MYMessageView.trailingAnchor,constant: -15),
          
            
            
        ])
    }

}
