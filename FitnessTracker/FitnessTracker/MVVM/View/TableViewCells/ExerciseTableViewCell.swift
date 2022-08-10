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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(exercise: Exercise) {
        exerciseName.text = exercise.exericiseName
        exerciseImageView.image = UIImage(named: exercise.imageName)
        repsCountLabel.text = exercise.repetition.toString()
        weightLabel.text = exercise.weight.toString()
        onOffSegmentController.selectedSegmentIndex = exercise.isExerciseOn ? 0 : 1
    }
    @IBAction func segmentoControllerAction(_ sender: Any) {
    }
    
}