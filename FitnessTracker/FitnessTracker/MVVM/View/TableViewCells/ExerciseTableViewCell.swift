//
//  ExerciseTableViewCell.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 14/07/22.
//

import UIKit

protocol ExerciseTableViewCellDelegate: AnyObject {
    func deleteExercise(exercise: Exercise)
    func updateExercise(exercise: Exercise)
}

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseName: UILabel!
    
    @IBOutlet weak var repsCountTextField: UITextField!
    @IBOutlet weak var weightLabelTextField: UITextField!
    
    @IBOutlet weak var numberOfSetsLabel: UIStackView!
    @IBOutlet weak var numberOfSetTextFields: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    var exercise: Exercise? = nil
    weak var exerciseTableViewCellDelegate: ExerciseTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(exercise: Exercise, userType: UserType, hideOnOffSwitch: Bool = false) {
        self.exercise = exercise
        exerciseName.text = exercise.exericiseName
        addDoneButtonOnKeyboard()
        if !exercise.imageName.isEmpty,
           let url =  Bundle.main.url(forResource:  exercise.imageName, withExtension: "gif"),
           let imageData = try? Data(contentsOf: url),
           let gifImage = UIImage.gifImageWithData(imageData) {
            exerciseImageView.image = gifImage
        } else if let imageData = exercise.imageData {
            exerciseImageView.image = UIImage(data: imageData)
        }  else {
            exerciseImageView.image = UIImage(systemName: "person.crop.circle.badge.questionmark.fill")
        }
        repsCountTextField.text = exercise.repetition.toString()
        weightLabelTextField.text = exercise.weight.toString()
        numberOfSetTextFields.text = exercise.set.toString()
//        onOffSegmentController.selectedSegmentIndex = exercise.isExerciseOn ? 0 : 1
//        onOffSegmentController.selectedSegmentTintColor = exercise.isExerciseOn ? UIColor.green : UIColor.lightGray
        deleteButton.isHidden = userType == .client
        //onOffSegmentController.isHidden = hideOnOffSwitch
    }
//    @IBAction func segmentoControllerAction(_ sender: Any) {
//        if onOffSegmentController.selectedSegmentIndex == 0 {
//            onOffSegmentController.selectedSegmentTintColor = .green
//            exercise?.isExerciseOn = true
//        } else {
//            onOffSegmentController.selectedSegmentTintColor = .lightGray
//            exercise?.isExerciseOn = false
//        }
//        if let exercise = exercise {
//            exerciseTableViewCellDelegate?.updateExercise(exercise: exercise)
//        }
//    }
    @IBAction func deleteButtonAction(_ sender: Any) {
        if let exercise = exercise {
            exerciseTableViewCellDelegate?.deleteExercise(exercise: exercise)
        }
    }
    
    @objc func addDoneButtonOnKeyboard(){
        // let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
       // doneToolbar.barStyle  = UIBarStyle.blackTranslucent
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))

        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()

        self.repsCountTextField.inputAccessoryView = doneToolbar
        self.weightLabelTextField.inputAccessoryView = doneToolbar
        self.numberOfSetTextFields.inputAccessoryView = doneToolbar

    }

    @objc func doneButtonAction(){
        if let repetition = repsCountTextField.text,
           let value = Int(repetition){
            exercise?.repetition = value
        }
        if let weight = weightLabelTextField.text,
           let value = Int(weight)  {
            exercise?.weight = value
        }
        if let set = numberOfSetTextFields.text,
           let value = Int(set)  {
            exercise?.set = value
        }
        if let exercise = exercise {
            exerciseTableViewCellDelegate?.updateExercise(exercise: exercise)
        }
        
    }
}
