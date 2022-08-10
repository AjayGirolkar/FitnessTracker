//
//  EditExerciseViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 03/08/22.
//

import UIKit

class EditExerciseViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    let picker = UIImagePickerController()
    var isExerciseEditModeOn: Bool = false
    var isDescriptionTextViewEditModeOn: Bool = false
    
    @IBOutlet weak var exerciseNameEditButton: UIButton!
    @IBOutlet weak var descriptionEditButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.allowsEditing = true
        picker.delegate = self
        updateEditCondition()
       addDismissKeyboardAction()
    }
    
    
    func updateEditCondition() {
        if isExerciseEditModeOn {
            exerciseNameTextField.isUserInteractionEnabled = true
            exerciseNameEditButton.image(for: .normal)
            exerciseNameEditButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            exerciseNameTextField.isUserInteractionEnabled = false
            exerciseNameEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
        if isDescriptionTextViewEditModeOn {
            descriptionTextView.isUserInteractionEnabled = true
            descriptionEditButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }else {
            descriptionTextView.isUserInteractionEnabled = false
            descriptionEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
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

extension EditExerciseViewController: UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
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
