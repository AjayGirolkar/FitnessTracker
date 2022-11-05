//
//  ToDoViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 13/07/22.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var exerciseList: [Exercise]?
    let userType: UserType
    var clientModel: ClientModel?
    
    @IBOutlet weak var addExerciseButton: UIButton!
    @IBOutlet weak var todoTableViewController: UITableView!
    
    required init?(coder: NSCoder, clientModel: ClientModel?, exerciseList: [Exercise]?, userType: UserType = .trainer) {
        self.exerciseList = exerciseList

        self.clientModel = clientModel
        self.userType = userType
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialViews()
        todoTableViewController.register(UINib.init(nibName: "ExerciseTableViewCell", bundle: nil),
                                         forCellReuseIdentifier: "ExerciseTableViewCell")
    }
    
    func configureInitialViews() {
        if userType == .client {
            addLogoutButton()
            addExerciseButton.isHidden = true
            todoTableViewController.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 30).isActive = true
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

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        tableViewCell.selectionStyle = .none
        tableViewCell.exerciseTableViewCellDelegate = self
        if let exericise =  exerciseList?[indexPath.row] {
            tableViewCell.configureCell(exercise: exericise, userType: userType, hideOnOffSwitch: userType == .client)
        }
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exercise = exerciseList?[indexPath.row] {
            let exerciseDetailsViewController = ExerciseDetailsViewController(exercise: exercise, userType: userType, clientModel: clientModel)
            exerciseDetailsViewController.selectExerciseDelegate = self
            self.navigationController?.pushViewController(exerciseDetailsViewController, animated: true)
        }
    }
}

extension ToDoViewController: ExerciseDelegate {
    func userSelectedExercise(exercise: Exercise) {
        exerciseList?.append(exercise)
        updateClientDetails()
    }
}

extension ToDoViewController: ExerciseTableViewCellDelegate {
    
    //This func is used to Delete exercise which selected by trainer.
    func deleteExercise(exercise: Exercise) {
        //Filter higher order func to update exercise list after removing selected exercise.
        exerciseList = exerciseList?.filter{ $0.id != exercise.id}
        updateClientDetails()
    }
    
    //This func used to update exericse list comparing with given id.
    func updateExercise(exercise: Exercise) {
        //map func Returns an array containing the results of mapping the given closure over the sequence’s elements.
        exerciseList = exerciseList?.map({ exerciseModel in
            if exercise.id == exerciseModel.id {
                return exercise
            }
            return exerciseModel
        })
        updateClientDetails()
    }
    
    func updateClientDetails() {
        saveTrainerModel()
        updateExerciseForClient()
        self.todoTableViewController.reloadData()
        
    }
    
    func saveTrainerModel(){
        if var updatedClientModel = clientModel {
            updatedClientModel.exerciseList = exerciseList
            SharedManager.shared.user.clientList =  SharedManager.shared.user.clientList?.map({ clientModel in
                if clientModel.name == self.clientModel?.name {
                    return updatedClientModel
                }
                return clientModel
            })
            UserDefaultManager.shared.trySavingUser(user: SharedManager.shared.user, completion: nil)
        }
    }
    func updateExerciseForClient() {
        if var client = UserDefaultManager.shared.isUserAvailable(username: self.clientModel?.username ?? "") {
            client.excerciseList = exerciseList
            UserDefaultManager.shared.trySavingUser(user: client, completion: nil)
        }
    }
}
