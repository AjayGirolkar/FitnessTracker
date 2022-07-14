//
//  ToDoViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 13/07/22.
//

import UIKit

class ToDoViewController: UIViewController {

    
    var clientModel: ClientModel
    
    required init?(coder: NSCoder, clientModel: ClientModel) {
        self.clientModel = clientModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
