//
//  ViewController.swift
//  AME264FinalProject
//
//  Created by Erik Nunez on 5/7/17.
//  Copyright © 2017 Erik Nunez. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController, AKKeyboardDelegate {

    let oscillator = AKOscillatorBank()
    
    @IBOutlet weak var slidervaluec: UISlider!
    @IBOutlet weak var slidervaluecsharp: UISlider!
    @IBOutlet weak var slidervalued: UISlider!
    @IBOutlet weak var slidervalueDsharp: UISlider!
    @IBOutlet weak var slidervaluee: UISlider!
    @IBOutlet weak var slidervaluef: UISlider!
    @IBOutlet weak var slidervaluefsharp: UISlider!
    @IBOutlet weak var slidervalueg: UISlider!
    @IBOutlet weak var slidervaluegsharp: UISlider!
    @IBOutlet weak var slidervaluea: UISlider!
    @IBOutlet weak var slidervaluebflat: UISlider!
    @IBOutlet weak var slidervalueb: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioKit.output = oscillator
        AudioKit.start()
        Audiobus.start()        
        setupUI()
    }
    
    var Cmicromult = slidervaluec
    var Csharpmmult = slidervaluecsharp
    var Dmmult = slidervalued
    var Dsharpmmult = slidervalueDsharp
    var Emmult = slidervaluee
    var Fmmult = slidervaluef
    var Fsharpmmult = slidervaluefsharp
    var Gmmult = slidervalueg
    var Gshaprmmult = slidervaluegsharp
    var Ammult = slidervaluea
    var Bflatmmult = slidervaluebflat
    var Bmmult = slidervalueb
    
    /// Returns a frequency for a given midi note number
    open func midiNoteToFrequency() -> AKOperation {
        
        var microtones1:Int = 0
        
        microtones1 = (AKOperation(module: "mtof", inputs: self)) % 12
        
        switch microtones1 {
        case 1:
            return microtones1*Cmicromult
        case 2:
            return microtones1*Csharpmmult
        case 3:
            return microtones1*Dmmult
        case 4:
            return microtones1*Dsharpmmult
        case 5:
            return microtones1*Emmult
        case 6:
            return microtones1*Fmmult
        case 7:
            return microtones1*Fsharpmmult
        case 8:
            return microtones1*Gmmult
        case 9:
            return microtones1*Gshaprmmult
        case 10:
            return microtones1*Ammult
        case 11:
            return microtones1*Bflatmmult
        case 12:
            return microtones1*Bmmult
        default:
            print("Nothing is playing")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let keyboardView = AKKeyboardView()
        keyboardView.delegate = self
        stackView.addArrangedSubview(keyboardView)
        
        view.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
 
    func noteOn(note: MIDINoteNumber) {
        synth.frequency = note.midiNoteToFrequency()
        synth.gate = 1
    }
    
    func noteOff(note: MIDINoteNumber) {
        synth.gate = 0
    }
    

}

