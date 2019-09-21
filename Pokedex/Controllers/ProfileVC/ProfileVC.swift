//
//  ProfileVC.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/16/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    
    var pokemonStats: [Int]!
    var pokemonTypes: [String]!
    var pokemonSpeed: Int!
    var pokemonStatisticsNames = ["Attack", "Defense", "Health", "Special Attack",
                                  "Special Defense", "Total"]
    
    var pokemonList: [Pokemon]!
    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successLabel.alpha = 0.0
        pokemonName.text = pokemon.name
        pokemonNumber.text = String(pokemon.number)
        
        pokemonStats = pokemon.stats
        pokemonTypes = pokemon.types
        pokemonSpeed = pokemon.speed
        
        guard let url = URL(string: pokemon.imageUrl) else {
            let image = UIImage(named: "question_mark")
            pokemonImage.image = image
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            pokemonImage.image = image
        } catch {
            let image = UIImage(named: "question_mark")
            pokemonImage.image = image
        }
        
        self.navigationItem.title = "Profile"
    }
    
    @IBAction func addToFavoritesPressed(_ sender: Any) {
        pokemon.isFavorite = true
        
        if var favoritePokemonList = UserDefaults.standard.array(forKey: "FavoritePokemonList") as? [Int] {
            favoritePokemonList.append(pokemon.number!)
            UserDefaults.standard.set(favoritePokemonList, forKey: "FavoritePokemonList")
        } else {
            let emptyArray = [Int]()
            UserDefaults.standard.set(emptyArray, forKey: "FavoritePokemonList")
        }
        fadeViewInThenOut()
    }
    
    @IBAction func searchOnTheWebPressed(_ sender: Any) {
        if let url = URL(string: "https://google.com/search?q=\(pokemon.name!)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func fadeViewInThenOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.successLabel.alpha = 1.0
          }, completion: {
              (finished: Bool) -> Void in
            UIView.animate(withDuration: 1.0, delay: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self.successLabel.alpha = 0.0
                    }, completion: nil)
        })
    }
}
