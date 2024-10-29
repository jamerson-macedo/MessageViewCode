//
//  HomeScreen.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 28/10/24.
//

import UIKit

class HomeScreen: UIView {
    lazy var navView: NavView = {
        let view = NavView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var collectionView : UICollectionView = {
        // inicia com um layout padrão
        let view = UICollectionView(frame: CGRect.zero,collectionViewLayout: UICollectionViewLayout.init())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(MessageLastCollectionViewCell.self, forCellWithReuseIdentifier: MessageLastCollectionViewCell.identifier)
        view.delaysContentTouches = false // remove delay na tela
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        view.setCollectionViewLayout(layout, animated: true)
        
        return view
    }()
    public func reloadCollectionView(){
        self.collectionView.reloadData()
    }
    public func delegateColletionView(delegate : UICollectionViewDelegate,datasource : UICollectionViewDataSource){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = datasource
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension HomeScreen : ViewCode{
    func addSubviews() {
        self.addSubview(self.navView)
        self.addSubview(self.collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140),
            
            self.collectionView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setupStyles() {
        
    }
    
    
}
