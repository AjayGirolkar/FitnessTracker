//
//  ClientDetailViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 11/07/22.
//

import UIKit

class ClientDetailViewController: UIViewController {

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
        self.title = clientModel.name
    }
}


