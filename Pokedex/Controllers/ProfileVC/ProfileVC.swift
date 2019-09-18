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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.text = pokemon.name
        pokemonNumber.text = String(pokemon.number)
        
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
    }
}
