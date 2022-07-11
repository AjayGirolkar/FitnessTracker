//
//  TrainerLandingVC.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/06/22.
//

import UIKit

class TrainerLandingVC: UIViewController {
    @IBOutlet weak var trainerTableView: UITableView!
    
    var clientList = [ClientModel(name: "Shrey", age: 20),
                      ClientModel(name: "Ajay", age: 29),
                      ClientModel(name: "Avenger", age: 40),
                      ClientModel(name: "Thor", age: 150),
                      ClientModel(name: "Hulk", age: 300),
                      ClientModel(name: "Iron Man", age: 35)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainerTableView.register(UINib.init(nibName: "TrainerTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "TrainerTableViewCell")
    }
}

//MARK: TableView Datasource, Delegate
extension TrainerLandingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TrainerTableViewCell", for: indexPath) as? TrainerTableViewCell else { return UITableViewCell() }
        tableViewCell.trainerLabel.text = clientList[indexPath.row].name
        return tableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clientModel = clientList[indexPath.row]
        navigateToClientViewController(clientModel: clientModel)
    }
    
    func navigateToClientViewController(clientModel: ClientModel) {
        let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
        let clientDetailViewController = trainerStoryBoard.instantiateViewController(identifier: "ClientDetailViewController", creator: { coder -> ClientDetailViewController? in
            ClientDetailViewController(coder: coder, clientModel: clientModel)
        })
        
        self.navigationController?.pushViewController(clientDetailViewController, animated: true)
    }
    
}
