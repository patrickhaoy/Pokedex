//
//  ListVC.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/16/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class ListVC: UIViewController {

    @IBOutlet weak var filteredPokemonTableView: UITableView!
    var typeSelected: [Bool]!
    var typeName = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    var pokemonList: [Pokemon]!
    var categoryFilteredPokemon: [Pokemon]!
    var currentIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryFilterPokemon()
    }
    
    func categoryFilterPokemon() {
        categoryFilteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
            var meetsConditions = true
            for typeIndex in 0..<typeName.count {
                if typeSelected[typeIndex] {
                    meetsConditions = meetsConditions && pokemon.types.contains(typeName[typeIndex])
                }
            }
            return meetsConditions
        })
    }
}
