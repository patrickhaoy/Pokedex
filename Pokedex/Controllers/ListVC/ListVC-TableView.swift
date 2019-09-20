//
//  ListVC-TableView.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/17/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

extension ListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFilteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        let pokemon: Pokemon
        pokemon = categoryFilteredPokemon[indexPath.row]
        cell.pokemonName.text = pokemon.name
        cell.pokemonNumber.text = String(pokemon.number)
        guard let url = URL(string: pokemon.imageUrl) else {
            let image = UIImage(named: "question_mark")
            cell.pokemonImage.image = image
            return cell
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                cell.pokemonImage.image = image
            }
        }
        return cell
    }
}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentIndexPath = indexPath
        self.performSegue(withIdentifier: "listToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProfileVC
        destinationVC.pokemon = categoryFilteredPokemon[currentIndexPath.row]
        destinationVC.pokemonList = pokemonList
    }
}
