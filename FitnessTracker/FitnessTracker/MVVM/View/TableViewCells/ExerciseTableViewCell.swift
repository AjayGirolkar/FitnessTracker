//
//  ExerciseTableViewCell.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 14/07/22.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var onOffSegmentController: UISegmentedControl!
    @IBOutlet weak var exerciseName: UILabel!
    
    @IBOutlet weak var repsCountLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberOfSetsLabel: UIStackView!
    
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
        exerciseName.text = exercise.exericiseName
        if let url =  Bundle.main.url(forResource:  exercise.imageName, withExtension: "gif"),
           let imageData = try? Data(contentsOf: url),
           let gifImage = UIImage.gifImageWithData(imageData) {
            exerciseImageView.image = gifImage
        }
        repsCountLabel.text = exercise.repetition.toString()
        weightLabel.text = exercise.weight.toString()
        onOffSegmentController.selectedSegmentIndex = exercise.isExerciseOn ? 0 : 1
        onOffSegmentController.isHidden = hideOnOffSwitch
    }
    @IBAction func segmentoControllerAction(_ sender: Any) {
        if onOffSegmentController.selectedSegmentIndex == 0 {
            onOffSegmentController.selectedSegmentTintColor = .green
        } else {
            onOffSegmentController.selectedSegmentTintColor = .lightGray
        }
    }
    
}
