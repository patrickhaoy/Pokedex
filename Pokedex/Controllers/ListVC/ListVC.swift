//
//  ListVC.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/16/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class ListVC: UIViewController {

    var typeList = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    @IBOutlet weak var filteredPokemonTableView: UITableView!
    var typeSelected: [Bool]!
    var pokemonList: [Pokemon]!
    var categoryFilteredPokemon: [Pokemon]!
    var currentIndexPath: IndexPath!
    
    var minAttackPoints, minDefensePoints, minHealthPoints: Int!
    var isRandom: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryFilterPokemon()
    }
    
    func categoryFilterPokemon() {
        if isRandom! {
            var remainingPokemonList: [Pokemon]  = pokemonList
            var randomPokemonList = [Pokemon]()
            
            for _ in 0..<20 {
                let randomPokemon = remainingPokemonList.randomElement()
                randomPokemonList.append(randomPokemon!)
                remainingPokemonList = remainingPokemonList.filter { $0.name != randomPokemon!.name }
            }
            
            categoryFilteredPokemon = randomPokemonList
            
        } else {
            categoryFilteredPokemon = pokemonList
            for i in 0..<typeSelected.count {
                if typeSelected[i] {
                    categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.types.contains(typeList[i]) }
                }
            }
            categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.attack >= minAttackPoints}
            categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.defense >= minDefensePoints}
            categoryFilteredPokemon = categoryFilteredPokemon.filter { $0.health >= minHealthPoints}
        }
    }
}
