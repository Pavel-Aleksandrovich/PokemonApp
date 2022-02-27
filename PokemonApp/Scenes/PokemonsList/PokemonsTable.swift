//
//  PokemonsTable.swift
//  PokemonApp
//
//  Created by pavel mishanin on 27.02.2022.
//

import UIKit

class PokemonsTable: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private var tableView: UITableView
    private let onCellTappedClosure: (Int) -> ()
    private var pokemons: [Poke] = []
    
    init(tableView: UITableView, onCellTappedClosure: @escaping (Int) -> ()) {
        self.tableView = tableView
        self.onCellTappedClosure = onCellTappedClosure
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setPokemons(pokemons: [Poke]) {
        self.pokemons = pokemons
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! PokemonCell
        
        cell.configure(note: pokemons[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PokemonDetails()
        vc.configure(pokemon: pokemons[indexPath.row])
        onCellTappedClosure(indexPath.row)
//        navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
//            self.getPokemons()
        }
    }
}
