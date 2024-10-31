
//
//  ViewCode.swift
//  Login ViewCode
//
//  Created by Jamerson Macedo on 16/10/24.
//

protocol ViewCode{
    func addSubviews() // adicionar outras views
    func setupConstraints() // define as constrants
   
}
extension ViewCode{
    func setup(){
        addSubviews()
        setupConstraints()
      
    }
}
