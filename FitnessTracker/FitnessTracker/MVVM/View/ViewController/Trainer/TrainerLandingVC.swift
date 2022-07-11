//
//  TrainerLandingVC.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/06/22.
//

import UIKit

class TrainerLandingVC: UIViewController {
    @IBOutlet weak var trainerTableView: UITableView!
    
    var clientList = ["Shrey", "Ajay", "Arjun", "Avenger", "Thor", "Hulk", "Iron Man"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainerTableView.register(UINib.init(nibName: "TrainerTableViewCell", bundle: nil), forCellReuseIdentifier: "TrainerTableViewCell")
    }
}


extension TrainerLandingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TrainerTableViewCell", for: indexPath) as? TrainerTableViewCell else { return UITableViewCell() }
        tableViewCell.trainerLabel.text = clientList[indexPath.row]
        return tableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clientName = clientList[indexPath.row]
        navigateToClientViewController(name: clientName)
    }
    
    func navigateToClientViewController(name: String) {
        let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
        guard let clientDetailViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "ClientDetailViewController") as? ClientDetailViewController else { return }
        self.navigationController?.pushViewController(clientDetailViewController, animated: true)
    }
}
