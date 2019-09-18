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
    let searchController = UISearchController(searchResultsController: nil)
    var currentIndexPath: IndexPath!
    
    // Bug, Grass, Dark, Ground, Dragon, Ice, Electric, Normal, Fairy, Poison, Fighting, Psychic, Fire, Rock, Flying, Steel, Ghost, Water
//    @IBOutlet weak var bugButton: UIButton!
//    @IBOutlet weak var grassButton: UIButton!
//    @IBOutlet weak var darkButton: UIButton!
//    @IBOutlet weak var groundButton: UIButton!
//    @IBOutlet weak var dragonButton: UIButton!
//    @IBOutlet weak var iceButton: UIButton!
//    @IBOutlet weak var electricButton: UIButton!
//    @IBOutlet weak var normalButton: UIButton!
//    @IBOutlet weak var fairyButton: UIButton!
//    @IBOutlet weak var poisonButton: UIButton!
//    @IBOutlet weak var fightingButton: UIButton!
//    @IBOutlet weak var psychicButton: UIButton!
//    @IBOutlet weak var fireButton: UIButton!
//    @IBOutlet weak var rockButton: UIButton!
//    @IBOutlet weak var flyingButton: UIButton!
//    @IBOutlet weak var steelButton: UIButton!
//    @IBOutlet weak var ghostButton: UIButton!
//    @IBOutlet weak var waterButton: UIButton!
    var typeButtonList: [UIButton]!
    var typeSelected: [Bool]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.navigationItem.title = "Pokédex"
        
        typeButtonList = [bugButton, grassButton, darkButton, groundButton, dragonButton, iceButton, electricButton, normalButton, fairyButton, poisonButton, fightingButton, fireButton, rockButton, flyingButton, steelButton, ghostButton, waterButton]
        for i in 0..<typeButtonList.count {
            typeSelected[i] = false
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
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.05, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.05, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
                
                for i in 0..<self.typeButtonList.count {
                    if sender == self.typeButtonList[i] {
                        self.typeSelected[i] = !self.typeSelected[i]
                        break
                    }
                }
                
            }, completion: nil)
        }
    }
    
    @IBAction func categorySearchTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "searchToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "searchToList":
                let destinationVC = segue.destination as! ListVC
                destinationVC.typeSelected = typeSelected
                destinationVC.pokemonList = pokemonList
            case "searchToProfile":
                let destinationVC = segue.destination as! ProfileVC
                destinationVC.pokemon = pokemonList[currentIndexPath.row]
            default: break
        }
    }
}

