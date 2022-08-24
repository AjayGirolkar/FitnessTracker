//
//  ClientDetailViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 11/07/22.
//

import UIKit

class ClientDetailViewController: UIViewController {
    
    var navigationTitle: String = ""
    var exerciseList: [Exercise]?
    let userType: UserType
    var clientModel: ClientModel?
    //ChilViewControllers
    var toDoViewController: ToDoViewController?
    var reviewViewController: ReviewViewController?
    
    @IBOutlet weak var toDoButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var childViewContainer: UIView!
    
    required init?(coder: NSCoder, navigationTitle: String,  exerciseList: [Exercise]?, clientModel: ClientModel?, userType: UserType) {
        self.exerciseList = exerciseList
        self.userType = userType
        self.navigationTitle = clientModel?.name ?? navigationTitle
        self.exerciseList = clientModel?.exerciseList ?? exerciseList
        self.clientModel = clientModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userType == .client {
            addLogoutButton()
        }
        updateNavigationBar()
        initializeChildViewControllers()
        addToDoViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = navigationTitle
    }
    
    func initializeChildViewControllers() {
        let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
        let reviewVC = ReviewViewController(nibName: "ReviewViewController", bundle: nil)
        let _  = reviewVC.view
        reviewVC.congifureView(clientModel: clientModel)
        let toDoVC = trainerStoryBoard.instantiateViewController(identifier: "ToDoViewController",
                                                                 creator: { coder -> ToDoViewController? in
            ToDoViewController(coder: coder,
                               clientModel: self.clientModel,
                               exerciseList: self.exerciseList,
                               userType: self.userType)
        })
        
        reviewViewController = reviewVC
        toDoViewController = toDoVC
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
