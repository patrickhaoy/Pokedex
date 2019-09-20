//
//  ViewController.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/16/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var pokemonTableView: UITableView!
    var pokemonList = PokemonGenerator.getPokemonArray().sorted(by: { $0.number < $1.number })
    var filteredPokemon = [Pokemon]()
    let searchController = UISearchController(searchResultsController: nil)
    var currentIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.navigationItem.title = "Pokédex"
        
        //Load favorites from UserDefaults
        if let favoritePokemonList = UserDefaults.standard.array(forKey: "FavoritePokemonList") as? [Int] {
            for pokemon in pokemonList {
                if favoritePokemonList.contains(pokemon.number) {
                    pokemon.isFavorite = true
                }
            }
        }
    }
    
    @IBAction func advancedSearchTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "searchToAdvSearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "searchToAdvSearch":
            let destinationVC = segue.destination as! AdvancedSearchVC
            destinationVC.pokemonList = pokemonList
        case "searchToProfile":
            let destinationVC = segue.destination as! ProfileVC
            if isFiltering() {
                destinationVC.pokemon = filteredPokemon[currentIndexPath.row]
            } else {
                destinationVC.pokemon = pokemonList[currentIndexPath.row]
            }
            destinationVC.pokemonList = pokemonList
        default: break
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
            return String(pokemon.number).contains(searchText) || pokemon.name.lowercased().contains(searchText.lowercased())
        })
        
        pokemonTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

