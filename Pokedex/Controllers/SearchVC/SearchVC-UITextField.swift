//
//  SearchVC-UITextField.swift
//  Pokedex
//
//  Created by Patrick Yin on 9/18/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
