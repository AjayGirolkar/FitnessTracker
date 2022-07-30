//
//  ToDoViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 13/07/22.
//

import UIKit

class ToDoViewController: UIViewController {

    var clientModel: ClientModel
    @IBOutlet weak var todoTableViewController: UITableView!
    
    required init?(coder: NSCoder, clientModel: ClientModel) {
        self.clientModel = clientModel
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
    }
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientModel.excerciseList?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        //tableViewCell.trainerLabel.text = clientList[indexPath.row].name
        return tableViewCell
    }
  
    
}

