//
//  GameViewController.swift
//  Accelerometer
//
//  Created by まちだこうたろう on 2023/02/19.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {

    @IBOutlet var awaImageView: UIImageView!
    let motionManager = CMMotionManager()
    var accelerationX: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {
                data, error in self.accelerationX = (data?.acceleration.x)!
                self.awaImageView.center.x += CGFloat(self.accelerationX * 20)
                
                if self.awaImageView.frame.origin.x < 40 {
                    self.awaImageView.frame.origin.x = 40
                }
                
                if self.awaImageView.frame.origin.x > 260 {
                    self.awaImageView.frame.origin.x = 260
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController: ResultViewController = segue.destination as! ResultViewController
        resultViewController.accelerationX = self.accelerationX
    }
}
