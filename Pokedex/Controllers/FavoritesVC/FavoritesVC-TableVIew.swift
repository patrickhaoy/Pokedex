//
//  FavoritesVC-TableVIew.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/19/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

extension FavoritesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        convertPokemonNumToPokemon()
        return favoritePokemonList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        let pokemon: Pokemon
        pokemon = favoritePokemonList[indexPath.row]
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
    
    func convertPokemonNumToPokemon () {
        var pokemonIndex = 0
        while pokemonIndex < favoritePokemonList.count {
            guard favoritePokemonNumList != nil else {
                favoritePokemonNumList = []
                return
            }
            if !favoritePokemonNumList.contains(favoritePokemonList[pokemonIndex].number) {
                favoritePokemonList.remove(at: pokemonIndex)
            } else {
                pokemonIndex += 1
            }
        }
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

