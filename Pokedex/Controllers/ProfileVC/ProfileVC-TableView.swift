//
//  ProfileVC-TableView.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/19/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonStats.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
        if indexPath.row < pokemonStats.count {
            cell.statisticsName.text = pokemonStatisticsNames[indexPath.row]
            cell.statistic.text = String(pokemonStats[indexPath.row])
        } else if indexPath.row == pokemonStats.count {
            cell.statisticsName.text = "Type(s)"
            
            var typeStatistic = ""
            for type in pokemon.types {
                typeStatistic += type + " "
            }
            cell.statistic.text = typeStatistic
        } else {
            cell.statisticsName.text = "Speed"
            cell.statistic.text = String(pokemonSpeed)
        }
        return cell
    }
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

