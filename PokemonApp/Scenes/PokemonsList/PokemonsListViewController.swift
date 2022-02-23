//
//  PokemonsListViewController.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import UIKit

protocol PokemonsListViewController: AnyObject {
    var addNoteButtonTappedHandler: (() -> ())? { get set }
}

final class PokemonsListViewControllerImpl: UIViewController, PokemonsListViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Notes"
    }
    
    private let tableView = UITableView()
    
    var addNoteButtonTappedHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAddNoteButton()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func createAddNoteButton() {
        let addNoteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteButtonTapped))
        self.navigationItem.rightBarButtonItem = addNoteButton
    }
    
    @objc private func addNoteButtonTapped() {
        self.addNoteButtonTappedHandler?()
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
        
//        cell.configure(note: note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
