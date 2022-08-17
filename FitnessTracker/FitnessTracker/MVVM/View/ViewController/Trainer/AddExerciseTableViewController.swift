//
//  AddExerciseTableViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 17/08/22.
//

import UIKit

protocol SelectExerciseDelegate: AnyObject {
    func userSelectedExercise(exercise: Exercise)
}

class AddExerciseTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseList = UserDefaultManager.shared.getExerciseList()
    weak var selectExerciseDelegate: SelectExerciseDelegate?
    
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
        // #warning Incomplete implementation, return the number of rows
        return exerciseList?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        tableViewCell.selectionStyle = .none
        if let exericise =  exerciseList?[indexPath.row] {
            tableViewCell.configureCell(exercise: exericise, userType: .trainer, hideOnOffSwitch: true)
        }
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exercise = exerciseList?[indexPath.row] {
            selectExerciseDelegate?.userSelectedExercise(exercise: exercise)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

