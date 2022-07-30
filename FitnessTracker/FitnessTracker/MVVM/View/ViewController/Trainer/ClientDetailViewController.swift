//
//  ClientDetailViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 11/07/22.
//

import UIKit

class ClientDetailViewController: UIViewController {
    
    var clientModel: ClientModel
    
    //ChilViewControllers
    var toDoViewController: ToDoViewController?
    var reviewViewController: ReviewViewController?
    
    @IBOutlet weak var toDoButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var childViewContainer: UIView!
    
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
        updateNavigationBar()
        initializeChildViewControllers()
        addToDoViewController()
    }
    
    func initializeChildViewControllers() {
        let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
        
        let reviewVC = trainerStoryBoard.instantiateViewController(identifier: "ReviewViewController",
                                                                   creator: { coder -> ReviewViewController? in
            ReviewViewController(coder: coder)
        })
        
        let toDoVC = trainerStoryBoard.instantiateViewController(identifier: "ToDoViewController",
                                                                 creator: { coder -> ToDoViewController? in
            ToDoViewController(coder: coder,
                               clientModel: self.clientModel)
        })
        
        reviewViewController = reviewVC
        toDoViewController = toDoVC
    }
    
    func updateNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left.2")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.left.2")
        navigationController?.navigationBar.tintColor = .black
    }
    
    //MARK: Button Action
    
    @IBAction func todoButtonAction(_ sender: Any) {
        addToDoViewController()
    }
    
    func addToDoViewController() {
        guard let toDoViewController = toDoViewController,
              let reviewViewController = reviewViewController else { return }
        remove(asChildViewController: reviewViewController)
        add(asChildViewController: toDoViewController)
        reviewButton.tintColor = .lightGray
        toDoButton.tintColor = UIColor(hex: "#64eb34")
        
    }
    
    @IBAction func reviewButtonAction(_ sender: Any) {
        guard let toDoViewController = toDoViewController,
              let reviewViewController = reviewViewController else { return }
        remove(asChildViewController: toDoViewController)
        add(asChildViewController: reviewViewController)
        toDoButton.tintColor = .lightGray
        reviewButton.tintColor = UIColor(hex: "#64eb34")

    }
}

extension ClientDetailViewController {
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        childViewContainer.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = childViewContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
}
