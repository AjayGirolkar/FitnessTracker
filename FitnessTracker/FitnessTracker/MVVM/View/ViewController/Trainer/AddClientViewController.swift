//
//  AddClientViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 18/08/22.
//

import UIKit

protocol AddClientDelegate: AnyObject {
    func updateClientModel(clientModel: ClientModel)
}

class AddClientViewController: UIViewController {
    
    var user: User = SharedManager.shared.user
    var clientModel = ClientModel(name: "", age: "10", imageData: nil, exerciseList: [], reviewModel: nil)
    weak var addClientDelegate: AddClientDelegate?
    @IBOutlet weak var addClientTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var newUserToAdd: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        searchBar.autocapitalizationType = .none
        addClientTableView.register(UINib.init(nibName: "ClientDetailsTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: "ClientDetailsTableViewCell")
        addClientTableView.register(UINib.init(nibName: "ExerciseTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: "ExerciseTableViewCell")
        addClientTableView.register(UINib.init(nibName: "SearchUserUTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: "SearchUserUTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Add client details"
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        updateTrainerDetails()
    }
    
    func updateTrainerDetails() {
        guard var newUserToAdd = newUserToAdd else {
            return
        }
        var isUserAlreadyPresent = false
        if let clientlist = user.clientList {
            for model in clientlist {
                if model.name == newUserToAdd.name {
                    isUserAlreadyPresent = true
                    showAlertView(title: "Failed", message: "client already present, please update client details from client list", primaryButtonText: "OK", secondaryButtonText: nil, secondaryButtonAction: nil)
                }
            }
        }
        
        if !isUserAlreadyPresent {
            clientModel.name = newUserToAdd.name
            clientModel.username = newUserToAdd.username
            clientModel.age = newUserToAdd.age?.toString()
            clientModel.imageData = newUserToAdd.imageData
            clientModel.reviewModel = newUserToAdd.reviewModel
            user.clientList?.append(clientModel)
            newUserToAdd.excerciseList = clientModel.exerciseList
            SharedManager.shared.user.clientList?.append(clientModel)
            UserDefaultManager.shared.trySavingUser(user: newUserToAdd, completion: nil)
            UserDefaultManager.shared.trySavingUser(user: user) { success in
                if success {
                    self.showAlertView(title: "Success", message: "Client added successfully", primaryButtonText: "ok", primaryButtonAction:  {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
    }
    
    @IBAction func addExerciseButtonAction(_ sender: Any) {
        let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
        if let addExerciseTableViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "AddExerciseTableViewController") as? AddExerciseTableViewController {
            addExerciseTableViewController.selectExerciseDelegate = self
            self.navigationController?.pushViewController(addExerciseTableViewController, animated: true)
        }
    }
}

extension AddClientViewController: UISearchBarDelegate {
    //This func return text entered by user in SearchBar.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //validate if user is available
        if let user = UserDefaultManager.shared.isUserAvailable(username: searchBar.text ?? "") {
            newUserToAdd = user
            searchBar.resignFirstResponder()
        } else {
            newUserToAdd = nil
        }
        addClientTableView.reloadData()
    }
}

extension AddClientViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : clientModel.exerciseList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let newUser = newUserToAdd {
                guard let clientDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ClientDetailsTableViewCell", for: indexPath) as? ClientDetailsTableViewCell  else { return UITableViewCell()}
                clientDetailsTableViewCell.configureCell(user: newUser)
                //self.clientDetailsTableViewCell = clientDetailsTableViewCell
                clientDetailsTableViewCell.selectionStyle = .none
                return clientDetailsTableViewCell
            } else {
                let searchUserUTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchUserUTableViewCell", for: indexPath)
                return searchUserUTableViewCell
            }
            
        } else {
            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
            tableViewCell.selectionStyle = .none
            tableViewCell.exerciseTableViewCellDelegate = self
            if let exerciseList = clientModel.exerciseList, exerciseList.count > indexPath.row {
                let exericise = exerciseList[indexPath.row]
                tableViewCell.configureCell(exercise: exericise, userType: user.type, hideOnOffSwitch: user.type == .client)
            }
            return tableViewCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exerciseList = clientModel.exerciseList, exerciseList.count > indexPath.row {
            let exercise = exerciseList[indexPath.row]
            let exerciseDetailsViewController = ExerciseDetailsViewController(exercise: exercise, userType: user.type, clientModel: clientModel)
            exerciseDetailsViewController.selectExerciseDelegate = self
            self.navigationController?.pushViewController(exerciseDetailsViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return newUserToAdd != nil ? "Client Name" : "No user found"
        case 1: return "Exercise details"
        default : return nil
        }
    }
}

extension AddClientViewController: ExerciseDelegate {
    func updateExercise(exercise: Exercise) {
        clientModel.exerciseList =  clientModel.exerciseList?.map({ exerciseModel in
            if exerciseModel.id == exerciseModel.id {
                return exercise
            }
            return exerciseModel
        })
        self.addClientTableView.reloadData()
    }
    
    func userSelectedExercise(exercise: Exercise) {
        clientModel.exerciseList?.append(exercise)
        self.addClientTableView.reloadData()
    }
}

extension AddClientViewController: ExerciseTableViewCellDelegate {
    func deleteExercise(exercise: Exercise) {
        clientModel.exerciseList = clientModel.exerciseList?.filter{ $0.id != exercise.id}
        self.addClientTableView.reloadData()
    }
}
