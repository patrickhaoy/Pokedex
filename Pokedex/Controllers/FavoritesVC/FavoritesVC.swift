//
//  FavoritesVC.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/16/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var favoritePokemonNumList = UserDefaults.standard.array(forKey: "FavoritePokemonList") as! [Int]
    var favoritePokemonList = PokemonGenerator.getPokemonArray().sorted(by: { $0.number < $1.number })
    var currentIndexPath: IndexPath!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritePokemonNumList = UserDefaults.standard.array(forKey: "FavoritePokemonList") as! [Int]
        favoritePokemonList = PokemonGenerator.getPokemonArray().sorted(by: { $0.number < $1.number })
        favoritesTableView.reloadData()
    }
}
