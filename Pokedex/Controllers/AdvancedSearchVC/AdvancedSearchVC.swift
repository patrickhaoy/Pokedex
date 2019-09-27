//
//  AdvancedSearchVC.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/20/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class AdvancedSearchVC: UIViewController {

    @IBOutlet weak var minHealthPoints: UITextField!
    @IBOutlet weak var minAttackPoints: UITextField!
    @IBOutlet weak var minDefensePoints: UITextField!
    
    var typeList = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    var typeSelected = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    var pokemonList: [Pokemon]!
    @IBOutlet weak var pokemonTypeCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        pokemonTypeCollectionView.isScrollEnabled = false;
        self.navigationItem.title = "Category Search"
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.05, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.05, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
                
                for i in 0..<self.typeList.count {
                    if sender.currentTitle == self.typeList[i] {
                        self.typeSelected[i] = !self.typeSelected[i]
                        continue
                    }
                }
            }, completion: nil)
        }
    }
    
    @IBAction func categorySearchTapped(_ sender: Any) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "advSearchToList", sender: self)
    }
    
    @IBAction func random20Tapped(_ sender: Any) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "advRandom20SearchToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "advSearchToList":
            let destinationVC = segue.destination as! ListVC
            destinationVC.typeSelected = typeSelected
            destinationVC.pokemonList = pokemonList
            
            destinationVC.minAttackPoints = Int(minAttackPoints.text ?? "String") ?? 0
            destinationVC.minDefensePoints = Int(minDefensePoints.text ?? "String") ?? 0
            destinationVC.minHealthPoints = Int(minHealthPoints.text ?? "String") ?? 0
            
            destinationVC.isRandom = false
        case "advRandom20SearchToList":
            let destinationVC = segue.destination as! ListVC
            destinationVC.pokemonList = pokemonList
            destinationVC.isRandom = true
        default: break
        }
    }
}
