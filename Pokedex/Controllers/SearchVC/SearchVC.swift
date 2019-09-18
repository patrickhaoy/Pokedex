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
    var pokemonList = PokemonGenerator.getPokemonArray()
    var filteredPokemon = [Pokemon]()
    let searchController = UISearchController(searchResultsController: nil) // Change to ListVC later
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        //loadImages()
    }
    
//    func loadImages() {
//        do {
//            let data = try Data(contentsOf: url)
//            let image = UIImage(data: data)
//            cell.pokemonImage.image = image
//            return cell
//        } catch {
//            let image = UIImage(named: "question_mark")
//            cell.pokemonImage.image = image
//            return cell
//        }
//
//        pokemonTableView.reloadData()
//    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
            return pokemon.name.lowercased().contains(searchText.lowercased())
        })
        
        pokemonTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

