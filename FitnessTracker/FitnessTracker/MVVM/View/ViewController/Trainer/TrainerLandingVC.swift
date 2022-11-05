//
//  TrainerLandingVC.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/06/22.
//

import UIKit

class TrainerLandingVC: UIViewController {
    @IBOutlet weak var trainerTableView: UITableView!
    var user: User = SharedManager.shared.user

    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainerTableView.register(UINib.init(nibName: "TrainerTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "TrainerTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = SharedManager.shared.user
        self.navigationItem.title = user.name
        navigationController?.navigationBar.prefersLargeTitles = true
        trainerTableView.reloadData()
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(loginVC, animated: true)
    }
    
    //This func called whenever screen is navigating from storyboard.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddClientViewControllerIdentfier" {
            //decide if destination controller is AddClientViewController and assign delegate to it.
            if let addClientViewController = segue.destination as? AddClientViewController {
                 addClientViewController.addClientDelegate = self
            }
        }
    }
}

//MARK: TableView Datasource, Delegate
extension TrainerLandingVC: UITableViewDataSource, UITableViewDelegate {
    
    //This function decide how many number of rows we need to present in section, which is based on number of client in this scenario.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.clientList?.count ?? 0
    }
    
    //This function decide which cell and data need to present in TrainerTableViewCell in resepecting lines.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TrainerTableViewCell", for: indexPath) as? TrainerTableViewCell else { return UITableViewCell() }
        tableViewCell.trainerLabel.text = user.clientList?[indexPath.row].name
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }
    
    //This function decide what action need to perform when user click on any row. here we are navigateToClientViewController.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let clientModel = user.clientList?[indexPath.row] {
            navigateToClientViewController(clientModel: clientModel)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Client Details"
    }
    
    func navigateToClientViewController(clientModel: ClientModel) {
        let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
        let clientDetailViewController = trainerStoryBoard.instantiateViewController(identifier: "ClientDetailViewController", creator: { coder -> ClientDetailViewController? in
            ClientDetailViewController(coder: coder, navigationTitle: clientModel.name,
                                       exerciseList: clientModel.exerciseList,
                                       clientModel: clientModel,
                                       userType: self.user.type)
        })
        
        self.navigationController?.pushViewController(clientDetailViewController, animated: true)
    }
    
}

extension TrainerLandingVC: AddClientDelegate {
    
    func updateClientModel(clientModel: ClientModel) {
        user.clientList?.append(clientModel)
        trainerTableView.reloadData()
        UserDefaultManager.shared.trySavingUser(user: user) { success in
            print("success")
        }
    }
}
