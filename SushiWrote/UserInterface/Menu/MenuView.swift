//
//  MenuView.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

class MenuView: UIView {
    
    var collectionView = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: CompositionalLayoutManager().createCompositionalLayout())

    
    init() {
        super.init(frame: CGRect())
        
        backgroundColor = .white
        setConstraints()
        
        collectionView.backgroundColor = .clear
        collectionView.register(SushiCell.self,
                                forCellWithReuseIdentifier: SushiCell.reuseId)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.reuseId)
    }
    
    func setConstraints() {
        
        Helper.addSub(views: [collectionView], to: self)
        Helper.tamicOff(views: [collectionView])
        
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 70),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)])
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
