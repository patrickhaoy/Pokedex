//
//  SearchVC-TableView.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/16/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredPokemon.count+1
        }
        return pokemonList.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
            let pokemon: Pokemon
            if isFiltering() {
                pokemon = filteredPokemon[indexPath.row]
            } else {
                pokemon = pokemonList[indexPath.row]
            }
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
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            currentIndexPath = indexPath
            self.performSegue(withIdentifier: "searchToProfile", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProfileVC
        destinationVC.pokemon = pokemonList[currentIndexPath.row]
    }
}
