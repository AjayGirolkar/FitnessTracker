//
//  ToDoViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 13/07/22.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var clientModel: ClientModel
    let userType: UserType
    
    @IBOutlet weak var todoTableViewController: UITableView!
    
    required init?(coder: NSCoder, clientModel: ClientModel, userType: UserType = .trainer) {
        self.clientModel = clientModel
        self.userType = userType
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableViewController.register(UINib.init(nibName: "ExerciseTableViewCell", bundle: nil),
                                         forCellReuseIdentifier: "ExerciseTableViewCell")
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
        return clientModel.exerciseList?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        tableViewCell.selectionStyle = .none
        if let exericise =  clientModel.exerciseList?[indexPath.row] {
            tableViewCell.configureCell(exercise: exericise, userType: userType, hideOnOffSwitch: userType == .client)
        }
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exercise = clientModel.exerciseList?[indexPath.row] {
            let exerciseDetailsViewController = ExerciseDetailsViewController(exercise: exercise, userType: userType)
            self.navigationController?.pushViewController(exerciseDetailsViewController, animated: true)
        }
    }
}

extension ToDoViewController: SelectExerciseDelegate {
    func userSelectedExercise(exercise: Exercise) {
        clientModel.exerciseList?.append(exercise)
        self.todoTableViewController.reloadData()
    }
}
