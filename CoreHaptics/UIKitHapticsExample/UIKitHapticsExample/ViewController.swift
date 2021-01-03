//
//  ViewController.swift
//  UIKitHapticsExample
//
//  Created by Julian Arias Maetschl on 01-01-21.
//

import UIKit
import CoreHaptics

class ViewController: UIViewController {

    let engine = try? CHHapticEngine()
    @IBOutlet weak var slider: UISlider!

    @IBOutlet weak var options: UISegmentedControl!

    var eventType: CHHapticEvent.EventType {
        options.selectedSegmentIndex == 0 ? .hapticTransient: .hapticContinuous
    }
    
    var hapticDict: [CHHapticPattern.Key: Any] {
        [
            CHHapticPattern.Key.pattern: [
                [CHHapticPattern.Key.event: [CHHapticPattern.Key.eventType: self.eventType,
                                             CHHapticPattern.Key.time: 0.01,
                                             CHHapticPattern.Key.eventDuration: slider.value]]
            ]
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let engine: CHHapticEngine = engine else { return }

        try? engine.start()

        engine.stoppedHandler = { reason in
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt: print("Audio session interrupt")
            case .applicationSuspended: print("Application suspended")
            case .idleTimeout: print("Idle timeout")
            case .systemError: print("System error")
            case .notifyWhenFinished: print("notifyWhenFinished")
            case .engineDestroyed: print("engineDestroyed")
            case .gameControllerDisconnect: print("gameControllerDisconnect")
            @unknown default:
                print("Unknown error")
            }
        }
    }

    @IBAction func onTap(_ sender: Any) {

        if let pattern = try? CHHapticPattern(dictionary: hapticDict) {
            let player = try? engine?.makePlayer(with: pattern)
            try? player?.start(atTime: 0.1)
        }

    }

}

