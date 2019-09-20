//
//  ViewController.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/16/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var minHealthPoints: UITextField!
    @IBOutlet weak var minAttackPoints: UITextField!
    @IBOutlet weak var minDefensePoints: UITextField!
    
    var typeList = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    var typeSelected = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
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
        self.performSegue(withIdentifier: "searchToList", sender: self)
    }
    
    @IBAction func random20Tapped(_ sender: Any) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "random20SearchToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "searchToList":
            let destinationVC = segue.destination as! ListVC
            destinationVC.typeSelected = typeSelected
            destinationVC.pokemonList = pokemonList
            
            destinationVC.minAttackPoints = Int(minAttackPoints.text ?? "String") ?? 0
            destinationVC.minDefensePoints = Int(minDefensePoints.text ?? "String") ?? 0
            destinationVC.minHealthPoints = Int(minHealthPoints.text ?? "String") ?? 0
            
            destinationVC.isRandom = false
        case "random20SearchToList":
            let destinationVC = segue.destination as! ListVC
            destinationVC.pokemonList = pokemonList
            destinationVC.isRandom = true
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

