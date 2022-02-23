//
//  PokemonsListViewController.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import UIKit

final class PokemonsListViewControllerImpl: UIViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private let tableView = UITableView()
    private var pokemons: [Poke] = []
    private var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getPokemons()
    }

    private func getPokemons() {
        
        NetworkManager.shared.getPokemons(page: offset) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case.success(let pokemons):
                self.pokemons.append(contentsOf: pokemons)
                self.offset += 10
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                self.showErrorAlert(error: error)
            }
        }
    }
    
    private func showErrorAlert(error: ErrorMessage) {
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert,animated: true)
    }
    
    private func configureView() {
        title = Constants.title
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PokemonsListViewControllerImpl: UITableViewDelegate, UITableViewDataSource {
    
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
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
            self.getPokemons()
        }
    }
}
