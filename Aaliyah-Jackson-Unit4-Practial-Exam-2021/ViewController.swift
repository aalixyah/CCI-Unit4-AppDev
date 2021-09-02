//
//  ViewController.swift
//  Aaliyah-Jackson-Unit4-Practial-Exam-2021
//
//  Created by AALIYAH on 05/06/2021.
//

/*
 An app where users can control the hue, saturtion and brightness of a UIview using sliders.
 The app also allows for the user to toggle into random mode which generates a random colour in the chosen corresponding mode.
 Information about the currrent values and mode is shown in app.
 The theme/background of the app is able to be changed to a random greyscale value when clicked (located in top right)
 */


import UIKit

class ViewController: UIViewController {
    
    //Outlets link UI objects with code read more: https://developer.apple.com/tutorials/app-dev-training/connecting-outlets-and-actions/
    
    //UIView read more: https://developer.apple.com/documentation/uikit/uiview/
    @IBOutlet weak var colourOutlet: UIView!
    
    //UISliders read more:https://developer.apple.com/documentation/uikit/uislider/
    @IBOutlet weak var hueSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var brightnessSlider: UISlider!
    
    //UIButtons read more: https://developer.apple.com/documentation/uikit/uibutton/
    
    @IBOutlet weak var neonModeButton: UIButton!
    @IBOutlet weak var pastelModeButton: UIButton!
    @IBOutlet weak var gothicModeButton: UIButton!
    @IBOutlet weak var backgroundColourButton: UIButton!
    
    
    //UISwitch read more: https://developer.apple.com/documentation/uikit/uiswitch/
    @IBOutlet weak var modeSwitch: UISwitch!
    
    //UILabels read more: https://developer.apple.com/documentation/uikit/uilabel/
    @IBOutlet weak var hueValueLabel: UILabel!
    @IBOutlet weak var saturationValueLabel: UILabel!
    @IBOutlet weak var brightnessValueLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
 
    
    
    
    //https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call our functions in here
        
        colourOutletDecorations()
        updateColourOutlet()
        
        //buttons
        randomBackgroundBrightness()
        neonMode()
        pastelMode()
        gothicMode()
        //labels
        updateHSBLabels()
    }
  
    
    //Actions read more: https://developer.apple.com/tutorials/app-dev-training/connecting-outlets-and-actions/
    
    //when a slider value is changed with any of the connected sliders we will call updateColourOutlet() and updateHSBLabels()
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        updateColourOutlet()
        updateHSBLabels()
    }
    
    // an action for the switch: if the switch is on then the mode buttons are enabled and all sliders are disabled (random mode) else the mode buttons are disabled and the sliders are enabled (Let me choose mode). The model label will be updated with to state which mode the app is in.
    
    @IBAction func colourModeSwitch(_ sender: UISwitch) {
        if sender.isOn{
            neonModeButton.isEnabled = true
            pastelModeButton.isEnabled = true
            gothicModeButton.isEnabled = true
            
            
            hueSlider.isEnabled = false
            saturationSlider.isEnabled = false
            brightnessSlider.isEnabled = false
                      
            
            modeLabel.text = "Toggle To Choose Your Own Colour 🐣"
        } else {
            neonModeButton.isEnabled = false
            pastelModeButton.isEnabled = false
            gothicModeButton.isEnabled = false
            
            
            hueSlider.isEnabled = true
            saturationSlider.isEnabled = true
            brightnessSlider.isEnabled = true
                      
            
            modeLabel.text = "Toggle To Enter Random Mode 🤪"
       
        }
    }
    
    
    
    // each mode button will have its own action which will call its corresponding mode function when pressed
    
    @IBAction func neonModeButtonAction(_ sender: UIButton) {
        neonMode()
    }
    
    @IBAction func pastelModeButtonAction(_ sender: UIButton) {
        pastelMode()
    }
    
    @IBAction func gothicModeButtonAction(_ sender: UIButton) {
    gothicMode()
    }
    
    // an action for the background button. when the button is pressed the randomBackgroundBrightness will be called
    @IBAction func backgroundButtonAction(_ sender: UIButton) {
        randomBackgroundBrightness()
    }
    
 

    //function to change the  UIView border read more: https://developer.apple.com/documentation/quartzcore/calayer/1410917-borderwidth
    func colourOutletDecorations() {
        colourOutlet.layer.borderWidth = 5
        colourOutlet.layer.cornerRadius = 20
        colourOutlet.layer.borderColor =
           UIColor.black.cgColor
    }
    
    //function to change the UIView's colour propery using the sliders
    func updateColourOutlet()  {
        //create variables of type cgFloat that will hold the value of the slider
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        
        //assign the varibles to the related slider value
        hue = CGFloat(hueSlider.value)
        saturation = CGFloat(saturationSlider.value)
        brightness = CGFloat(brightnessSlider.value)
        
        /* create a constant called colour and have it equal UIColor
        
         UIColor - "An object that stores color data and sometimes opacity."
        https://developer.apple.com/documentation/uikit/uicolor
          pass UIcolor the varibles that were assigned the related slider value */
        
        let colour = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        
        //Have our UIView's (colourOutlet) background property = colour which takes the values from the slider
        
        colourOutlet.backgroundColor = colour
        
    }
    
    /* A function that converts current slider values to the standard HSB colour format
        where:
     
     hue = a number between 0 and 360 measured in degrees °
     saturation = a number between 0 and 100 written as a percentage %
     brightness = a number between 0 and 100 written as a percentage %
     
     read more https://learnui.design/blog/the-hsb-color-system-practicioners-primer.html
        */
 
    func updateHSBLabels() {
        
        //create a constant for the slider value multiply by 100 to make a percentage the slider value is a number between 0 and 1
        let saturationPercentage = saturationSlider.value * 100
        
        let brightnessPercentage = brightnessSlider.value * 100
        
        //create a constant for the hue which will be measured in degrees. The slider value is a number between 0 and 1 so multiply by 360 to get the value in degrees
        let hueDegrees = hueSlider.value * 360
        
        
        /*As the value is a cgfloat we must convert the value to an intiger so there are no floating points
         read more: https://developer.apple.com/documentation/swift/int/
         https://developer.apple.com/documentation/coregraphics/cgfloat/
         */
        
        
        let brighnessFormatted: Int = Int(brightnessPercentage)
        
        let saturationFormatted: Int = Int( saturationPercentage)
        
        let hueFormatted: Int = Int(hueDegrees)
        
        //make the text string of each corresponding label the formatted slider value and add symbols
     
        hueValueLabel.text = " \(hueFormatted)°"
        
        saturationValueLabel.text = "\(saturationFormatted )%"
        
        brightnessValueLabel.text = "\( brighnessFormatted)%"
    }
    
    
    
    
    //A  series of functions which will change the colourOutlet.background to a random colour in correspoding the mode
    func neonMode()  {
        
        /*Assign the constant random hue value a random CGfloat in the range of 0 - 1
         random value
         
         read more about the method:https://developer.apple.com/documentation/swift/double/2995407-random/
        */
        let randomHueValue = CGFloat.random(in: 0...1)
    
        //The constant colour will have a random hue value with full brightness,  saturation and alpha
        
        let colour = UIColor(
            hue: randomHueValue,
            saturation: 1,
            brightness: 1,
            alpha: 1)
        
        //Assign our UIView's (colourOutlet) background property with our colour
        
        colourOutlet.backgroundColor = colour
        
    }
    
    func pastelMode()  {
        
        /*Assign the constant random hue value a random CGfloat in the range of 0 - 1
        */
        let randomHueValue = CGFloat.random(in: 0...1)
       
    
        //Constant colour will have a random hue value with full brighness and alpha and a low saturation value of 0.1 producing a random pastel colour
        
        let colour = UIColor(
            hue: randomHueValue,
            saturation: 0.1,
            brightness: 1,
            alpha: 1)
        
        //Assign our UIView's (colourOutlet) background property with our colour
        
        colourOutlet.backgroundColor = colour
        
    }
    
    func gothicMode()  {
        
        /*Assign the constant randomHueValue a random CGfloat in the range of 0 - 1
        */
        let randomHueValue = CGFloat.random(in: 0...1)
    
        //Constant colour will have a random hue value with full saturation and alpha. The brighness will be low a value of 0.2 producing a random dark gothic colour
        
        let colour = UIColor(
            hue: randomHueValue,
            saturation: 1,
            brightness: 0.2,
            alpha: 1)
        
        //Assign our UIView's (colourOutlet) background property with our colour
        
        colourOutlet.backgroundColor = colour
        
    }
    
    //a function that will change the background to a random greyscale colour
    func randomBackgroundBrightness() {
        
        let randomBrightnessValue = CGFloat.random(in: 0...1)
        
        let colour = UIColor(hue: 0
                             , saturation: 0, brightness: randomBrightnessValue, alpha: 1)
        view.backgroundColor = colour
    }
    

}

