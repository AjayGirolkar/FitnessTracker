//
//  AddExerciseTableViewController.swift
//  FitnessTracker
//
//  Created by Shrey Bansal on 17/08/22.
//

import UIKit

protocol ExerciseDelegate: AnyObject {
    func userSelectedExercise(exercise: Exercise)
    func updateExercise(exercise: Exercise)
}

class AddExerciseTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseList = UserDefaultManager.shared.getExerciseList()
    weak var selectExerciseDelegate: ExerciseDelegate?
    let emptyExercise = Exercise(exericiseName: "Enter exercise name", imageName: "", repetition: 10, set: 5, weight: 20, isExerciseOn: false, exerciseDescription: "Enter description here")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Exercise"
        updateNavigationBar()
        tableView.register(UINib.init(nibName: "ExerciseTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "ExerciseTableViewCell")
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let exerciseCount = exerciseList?.count ?? 0
        return exerciseCount + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        tableViewCell.selectionStyle = .none
        if let exerciseList = exerciseList, indexPath.row < exerciseList.count {
            let exercise =  exerciseList[indexPath.row]
            tableViewCell.configureCell(exercise: exercise, userType: .trainer, hideOnOffSwitch: true)
        } else {
            tableViewCell.configureCell(exercise: emptyExercise, userType: .trainer, hideOnOffSwitch: true)
        }
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exerciseList = exerciseList, indexPath.row < exerciseList.count {
            let exercise =  exerciseList[indexPath.row]
            selectExerciseDelegate?.userSelectedExercise(exercise: exercise)
            self.navigationController?.popViewController(animated: true)
        } else {
            selectExerciseDelegate?.userSelectedExercise(exercise: emptyExercise)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

