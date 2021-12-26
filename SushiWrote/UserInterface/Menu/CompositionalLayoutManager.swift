//
//  CompositionalLayoutManager.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

class CompositionalLayoutManager {
    
    enum Section: Int, CaseIterable {
        case classical, burned, maki, sets
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            guard let _ = Section(rawValue: sectionIndex) else {
                fatalError("Не удалось создать секцию")
            }
            
            return self.createSection()
            
        }
        
        return layout
        
    }
    
    func createSection() -> NSCollectionLayoutSection {
        
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47),
                                              heightDimension: .fractionalHeight(0.95))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let spacing: CGFloat = 12
        group.interItemSpacing = .fixed(spacing)
        
        //section
        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                        leading: 8,
                                                        bottom: 8,
                                                        trailing: 8)
        
        section.boundarySupplementaryItems = [createHeader()]
        
        return section
        
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        
        header.zIndex = 2
        
        return header
        
    }
    
    
}
