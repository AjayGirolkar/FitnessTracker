//
//  UserLandingVC.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/06/22.
//

import UIKit

class UserLandingVC: UIViewController {

    @IBOutlet weak var userLandingTableView: UITableView!
    var user: User = SharedManager.shared.user

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLogoutButton()
        self.navigationItem.title = "Timeline"
        navigationController?.navigationBar.prefersLargeTitles = true
        userLandingTableView.register(UINib.init(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: "ExerciseTableViewCell")
    }
}

extension UserLandingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.excerciseList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        if let exericise =  user.excerciseList?[indexPath.row] {
            tableViewCell.configureCell(exercise: exericise, userType: user.type, hideOnOffSwitch: user.type == .client)
        }
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exercise = user.excerciseList?[indexPath.row] {
            let exerciseDetailsViewController = ExerciseDetailsViewController(exercise: exercise, userType: user.type)
        self.navigationController?.pushViewController(exerciseDetailsViewController, animated: true)
        }
    }
}
