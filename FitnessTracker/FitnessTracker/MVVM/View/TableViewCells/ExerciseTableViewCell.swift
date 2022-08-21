//
//  ExerciseTableViewCell.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 14/07/22.
//

import UIKit

protocol ExerciseTableViewCellDelegate: AnyObject {
    func deleteExercise(exercise: Exercise)
}

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var onOffSegmentController: UISegmentedControl!
    @IBOutlet weak var exerciseName: UILabel!
    
    @IBOutlet weak var repsCountLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberOfSetsLabel: UIStackView!
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
        repsCountLabel.text = exercise.repetition.toString()
        weightLabel.text = exercise.weight.toString()
        onOffSegmentController.selectedSegmentIndex = exercise.isExerciseOn ? 0 : 1
        deleteButton.isHidden = userType == .client
        onOffSegmentController.isHidden = hideOnOffSwitch
    }
    @IBAction func segmentoControllerAction(_ sender: Any) {
        if onOffSegmentController.selectedSegmentIndex == 0 {
            onOffSegmentController.selectedSegmentTintColor = .green
        } else {
            onOffSegmentController.selectedSegmentTintColor = .lightGray
        }
    }
    @IBAction func deleteButtonAction(_ sender: Any) {
        if let exercise = exercise {
            exerciseTableViewCellDelegate?.deleteExercise(exercise: exercise)
        }
    }
}
