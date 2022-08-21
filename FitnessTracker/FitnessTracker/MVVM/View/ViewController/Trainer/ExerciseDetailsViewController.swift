//
//  EditExerciseViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 03/08/22.
//

import UIKit

class ExerciseDetailsViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    let picker = UIImagePickerController()
    var isExerciseEditModeOn: Bool = false
    var isDescriptionTextViewEditModeOn: Bool = false
    
    @IBOutlet weak var exerciseNameEditButton: UIButton!
    @IBOutlet weak var descriptionEditButton: UIButton!
    var exercise: Exercise
    let userType: UserType
    var clientModel: ClientModel?
    weak var selectExerciseDelegate: ExerciseDelegate?
    
    init(exercise: Exercise, userType: UserType, clientModel: ClientModel? = nil) {
        self.exercise = exercise
        self.userType = userType
        self.clientModel = clientModel
        super.init(nibName: "ExerciseDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.allowsEditing = true
        picker.delegate = self
        updateNavigationBar()
        configureViews()
        updateEditCondition()
        addDismissKeyboardAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userType == .trainer {
            addSaveButton()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    func configureViews() {
        if !exercise.imageName.isEmpty,
           let url =  Bundle.main.url(forResource:  exercise.imageName, withExtension: "gif"),
           let imageData = try? Data(contentsOf: url),
           let gifImage = UIImage.gifImageWithData(imageData) {
            imageView.image = gifImage
        } else if let imageData = exercise.imageData {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.image = UIImage(systemName: "person.crop.circle.badge.questionmark.fill")
        }
        title = exercise.exericiseName
        exerciseNameTextField.text = exercise.exericiseName
        descriptionTextView.text = exercise.exerciseDescription
        if userType == .client {
            exerciseNameEditButton.isHidden = true
            descriptionEditButton.isHidden = true
        }
    }
    
    func addSaveButton() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonAction() {
        exercise.exericiseName = exerciseNameTextField.text ?? ""
        exercise.exerciseDescription = descriptionTextView.text
        exercise.imageData = imageView.image?.pngData()
        saveTrainerModel()
    }
    
    func saveTrainerModel(){
        if var updatedClientModel = clientModel {
            updatedClientModel.exerciseList = clientModel?.exerciseList?.map({ exerciseDetail in
                if exerciseDetail.id == self.exercise.id {
                    return self.exercise
                }
                return exerciseDetail
            })
            SharedManager.shared.user.clientList =  SharedManager.shared.user.clientList?.map({ clientModel in
                if clientModel.name == updatedClientModel.name {
                    return updatedClientModel
                }
                return clientModel
            })
            UserDefaultManager.shared.trySavingUser(user: SharedManager.shared.user, completion: { success in
                if success {
                    self.showAlertView(title: "Success", message: "Saved changes", primaryButtonText: "Ok", primaryButtonAction:  {
                        self.selectExerciseDelegate?.updateExercise(exercise: self.exercise)
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            })
        }
    }
    
    func updateEditCondition() {
        if isExerciseEditModeOn {
            exerciseNameTextField.isUserInteractionEnabled = true
            exerciseNameEditButton.image(for: .normal)
            exerciseNameEditButton.setImage(ImageName.doneImage, for: .normal)
        } else {
            exerciseNameTextField.isUserInteractionEnabled = false
            exerciseNameEditButton.setImage(ImageName.pencil, for: .normal)
        }
        if isDescriptionTextViewEditModeOn {
            descriptionTextView.isUserInteractionEnabled = true
            descriptionEditButton.setImage(ImageName.doneImage, for: .normal)
        }else {
            descriptionTextView.isUserInteractionEnabled = false
            descriptionEditButton.setImage(ImageName.pencil, for: .normal)
        }
    }
    
    @IBAction func imagePickerAction(_ sender: Any) {
        present(picker, animated: true)
    }
    
    
    @IBAction func editExerciseNameButtonAction(_ sender: Any) {
        isExerciseEditModeOn = !isExerciseEditModeOn
        updateEditCondition()
    }
    
    @IBAction func editDescriptionButtonAction(_ sender: Any) {
        isDescriptionTextViewEditModeOn = !isDescriptionTextViewEditModeOn
        updateEditCondition()
    }
}

extension ExerciseDetailsViewController: UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true)
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
