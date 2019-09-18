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
    var pokemonList: [Pokemon]!
    var categoryFilteredPokemon: [Pokemon]!
    var currentIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //categoryFilterPokemon()
    }
    
//    func categoryFilterPokemon() {
//        categoryFilteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
//            if bugSelected {
//                return pokemon.types.contains("Bug")
//            } else {
//                return true
//            }
//        })
//    }
}
