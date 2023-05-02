//
//  ViewController.swift
//  TrafficLight
//
//  Created by Andrey Krapivin on 28.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum TrafficLightState {
        case off
        case red
        case yellow
        case green
        
        func isOff() -> Bool {
            self == .off
        }
    }

    @IBOutlet var greenLightView: UIView!
    @IBOutlet var yellowLightView: UIView!
    @IBOutlet var redLightView: UIView!
    @IBOutlet var nextButton: UIButton!

    var currentState = TrafficLightState.off
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshState(for: currentState)
    }

    @IBAction func nextButtonDidTapped(_ sender: Any) {
        let statesWorkflow: [TrafficLightState: TrafficLightState] = [
            .off: .red,
            .red: .yellow,
            .yellow: .green,
            .green: .red,
        ]
        
        currentState = statesWorkflow[currentState] ?? .off
        
        refreshState(for: currentState)
    }

    private func refreshState(for state: TrafficLightState) {
        let statesViewMap: [TrafficLightState: (UIView, UIColor)] = [
            .red:    (redLightView, .red),
            .yellow: (yellowLightView, .yellow),
            .green:  (greenLightView, .green),
        ]
        
        for (lightState, (lightView, lightColor)) in statesViewMap {
            lightView.layer.cornerRadius = lightView.frame.width / 2
            lightView.backgroundColor = lightColor
            lightView.alpha = state == lightState ? 1 : 0.3
        }
        
        nextButton.setTitle(state.isOff() ? "START" : "NEXT", for: .normal)
    }
    
}

