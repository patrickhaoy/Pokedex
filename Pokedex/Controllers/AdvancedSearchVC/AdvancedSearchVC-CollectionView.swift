//
//  SearchVC-CollectionView.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/18/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

extension AdvancedSearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
        cell.typeButton.setTitle(typeList[indexPath.row], for: .normal)
        return cell
    } 
}
