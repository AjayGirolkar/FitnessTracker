//
//  Constants.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 14/07/22.
//

import Foundation
import UIKit

struct Image {
    static let pencil = UIImage(systemName: "pencil")
    static let lockImage = UIImage(systemName: "lock.fill")
    static let doneImage = UIImage(systemName: "checkmark.circle")
}




struct ExerciseName {
    static let barbellCurl = "barbellCurl"
    static let chestpress = "chestpress"
    static let bridgeExercise = "bridgeExercise"
    static let lunges = "lunges"
    static let legExtension = "legExtension"
    static let shoulderPress = "shoulderPress"
    static let pullups = "pullups"
    static let tBarRow = "tBarRow"
    
    //Gif
    static let latPullDown = "latPullDown"
    static let dumbbellCurl = "dumbbellCurl"
    static let chestPress = "chestPress"
    static let crunches = "crunches"
    static let concentrationCurl = "concentrationCurl"
    static let pullUps = "pullUps"
    static let pushUps = "pushUps"
    static let squat = "squat"
}


struct ExerciseDescriptions {
    
    static let latPullDown =
    """
1. Sit comfortably on the pulldown seat, with your feet flat on the floor. Check the height of the bar. You may need to adjust the bar height by shortening or lengthening the chain or cable that supports the bar or your seat height.

2. The bar should be at a height that your outstretched arms can comfortably grasp the bar without having to stand up entirely, but you should also be able to still extend your arms to achieve a full range of motion. If the station has a thigh pad, adjust it so that the upper thighs are tucked firmly under the pad. This will assist you when you apply effort to the bar.

3. Grasp the bar with a wide grip with an overhand, knuckles-up grip. Other positions and grips are possible but start with this standard position.
4. Pull the bar down until it's approximately level with the chin. Exhale on the downward motion. While shifting slightly backward is OK, aim to keep your upper torso stationary. Keep your feet flat on the floor and engage your abs as you pull. The bottom of the motion should be where your elbows can't move downward anymore without moving backward. Be sure to stop at that point and do not go lower.
5. Squeeze the shoulder blades together while maintaining square shoulders.
6. From the bottom position, with the bar close to your chin, slowly return the bar to the starting position while controlling its gradual ascent. Don't let it crash into the weight plates.
7. Continue until you complete eight to 12 repetitions in a set. Rest, then continue to complete your program of sets.
"""
    
    
    static let dumbbellCurl =
    """
1. Select dumbbells of a weight you can lift 10 times with good form. Suggested starting weights are 5 pounds or 10 pounds per dumbbell. If you are just beginning, rehabilitating from an injury, or returning to exercise after a sedentary period, you might start with 2 pounds.

2. Begin standing tall with your feet about hip-width apart. Keep your abdominal muscles engaged.
3. Hold one dumbbell in each hand. Let your arms relax down at the sides of your body with palms facing forward.
4. Keeping your upper arms stable and shoulders relaxed, bend at the elbow and lift the weights so that the dumbbells approach your shoulders. Your elbows should stay tucked in close to your ribs. Exhale while lifting.
5. Lower the weights to the starting position.
6. Do 8–10 curls, then rest and do one or two more sets.
"""
    
    static let chestPress =
    """
While you can do the chest press with a variety of equipment (see Variations, below), these instructions use dumbbells.

1. Lie on a bench or floor with a dumbbell in each hand. If you use a bench, you may have your feet up on the bench or on the floor, whichever is comfortable for bench height and your body and leg length.
2. Position the dumbbells at the shoulders with upper arms at about 45 degrees to the body. Keep elbows forward of the shoulder line to avoid stress on the shoulder joint. The palms should face forward and your thumbs should be wrapped around the handle.
3. Brace the abdominal muscles, tilt the chin slightly toward the chest and ensure you are in a stable and comfortable position. You're ready to lift.
4. Push the weights upward while exhaling, taking care not to lock out the elbows in an explosive movement. The weights should follow a shallow arc and almost meet over the top of the chest. It's OK to straighten the arms as long as you don’t do it with sudden or explosive force. The head and shoulder blades should not rise off the bench or floor.
5. Lower the weights, muscles contracted, while inhaling and controlling the return to the starting position.
"""
    
    static let crunches = """
1. Lie down on the floor on your back and bend your knees, placing your hands behind your head or across your chest. Some people find that crossing the arms over the chest helps them avoid pulling on the neck. However, if you find your neck is strained, you can keep one hand cradling the head. If you are putting your hands behind your head, your fingers should gently cradle your head. The idea is to support your neck without taking away from the work of your abs.
2. Pull your belly button towards your spine in preparation for the movement.
3. Slowly contract your abdominals, bringing your shoulder blades about 1 or 2 inches off the floor.
4. Exhale as you come up and keep your neck straight, chin up. Imagine you're holding a tennis ball under your chin. That's about the angle you want to keep the chin the entire time.
5. Hold at the top of the movement for a few seconds, breathing continuously.
6. Slowly lower back down, but don't relax all the way.
7. Repeat for 15 to 20 repetitions with perfect form for each rep.
"""
    
   static let concentrationCurl = """
Follow these form cues to learn how to do the concentration curl. Once you've read the step-by-step directions, follow along for some higher-level tips from Samuel to dive deeper into the exercise.

1. Sit on a bench, with a dumbbell between your legs.

2. Grab the dumbbell with one hand, then place your upper arm (your triceps muscle) against your thigh. Your goal should be to keep your arm perpendicular to the ground throughout the whole movement.

3. Tighten your core and engage your shoulder blades to create tension and reinforce posture.

4. Make a fist with your off hand and extend your non-working arm out to the side. This allows you to use your core to balance and remove any leverage that would take away from biceps engagement.

5. Curl the weight up with control, keeping the wrist in a neutral position. Emphasize the squeeze at the top of the rep; avoid any backwards lean or shoulder movement, keeping the focus on the biceps.

6. Perform 3 sets of 8 to 12 reps per arm, or 3 minutes alternating 30 seconds of work per arm.
"""
    
    static let pullUps = """
The pullup bar should be at a height that requires you to jump up to grab it; your feet should hang free. Stand below the bar with your feet shoulder width apart. Jump up and grip the bar with an overhand grip about shoulder width apart. Fully extend your arms so you are in a dead hang. Bend your knees and cross your ankles for a balanced position. Take a breath at the bottom.

1. Exhale while pulling yourself up so your chin is level with the bar. Pause at the top.
2. Lower yourself (inhaling as you go down) until your elbows are straight.
3. Repeat the movement without touching the floor.
4. Complete the number of repetitions your workout requires.
"""
    
    static let pushUps = """
To do a push-up you are going to get on the floor on all fours, positioning your hands slightly wider than your shoulders. Don't lock out the elbows; keep them slightly bent. Extend your legs back so you are balanced on your hands and toes, your feet hip-width apart. Once in this position, here is how you will do a push-up.

1. Contract your abs and tighten your core by pulling your belly button toward your spine.
2. Inhale as you slowly bend your elbows and lower yourself to the floor, until your elbows are at a 90-degree angle.
3. Exhale while contracting your chest muscles and pushing back up through your hands, returning to the start position.
4. Keep a tight core throughout the entire push-up. Also, keep your body in a straight line from head to toe without sagging in the middle or arching your back.
"""
    
    static let squat = """
Safety and proper form is essential to keep your body safe and healthy:

1. Keep the knees in line with the toes.
2. Keep the shoulders back, a natural arch in the lower back, and the head and neck in a neutral position throughout the exercise.
3. Keep the weight over the ankles and keep the heels on the floor throughout the movement.
4. Remember to send the hips back rather than the knees forward.
"""
}
