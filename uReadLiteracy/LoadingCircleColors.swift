//
//  LoadingCircleColors.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/24/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class LoadingCircleColors{

    private var redRGB:[CGFloat] = [255,141,84]
    private var orangeRGB:[CGFloat] = [255,217,84]
    private var yellowRGB:[CGFloat] = [255,255,0]
    private var lightGreenRGB:[CGFloat] = [157,255,0]
    private var greenRGB:[CGFloat] = [95,255,0]
    

    
    static var sharedInstance = LoadingCircleColors()
    
    private func getRedToOrangeColor(numberOfColor:Int) -> [CGColor]{
        var totalColors = [CGColor]()
        for x in 0...numberOfColor{
            let color = UIColor.init(red: redRGB[0]/255, green: (redRGB[1] + CGFloat(x)*abs(orangeRGB[1]-redRGB[1])/CGFloat(numberOfColor))/255, blue: redRGB[2]/255, alpha: 1).cgColor
            
            totalColors.append(color)
        }
        return totalColors
    }
    
    private func getOrangeToYellowColor(numberOfColor:Int) -> [CGColor]{
        var totalColors = [CGColor]()
        for x in 0...numberOfColor{
            let color = UIColor.init(red: 255/255, green: (orangeRGB[1] + CGFloat(x)*abs(yellowRGB[1]-orangeRGB[1])/CGFloat(numberOfColor))/255, blue: (orangeRGB[2] - CGFloat(x)*abs(yellowRGB[2]-orangeRGB[2])/CGFloat(numberOfColor))/255, alpha: 1).cgColor
            
            totalColors.append(color)
        }
        return totalColors
    }
    
    private func getYellowToLightGreenColor(numberOfColor:Int) -> [CGColor]{
        var totalColors = [CGColor]()
        for x in 0...numberOfColor{
            let color = UIColor.init(red: (yellowRGB[0] - CGFloat(x)*abs(lightGreenRGB[0]-yellowRGB[0])/CGFloat(numberOfColor))/255, green: 255/255, blue: 0, alpha: 1).cgColor
            
            totalColors.append(color)
        }
        return totalColors
    }
    
    private func getLightGreenToGreenColor(numberOfColor:Int) -> [CGColor]{
        var totalColors = [CGColor]()
        for x in 0...numberOfColor{
            let color = UIColor.init(red: (lightGreenRGB[0] - CGFloat(x)*abs(greenRGB[0]-lightGreenRGB[0])/CGFloat(numberOfColor))/255, green: 255/255, blue: 0, alpha: 1).cgColor
            
            totalColors.append(color)
        }
        return totalColors
    }
    
    func getColorGroup(percent: Int, numberOfColorChange: Int) -> [CGColor]{
        var colorGroup = [CGColor]()
        
        if percent < 25{
            let numberOfRedToOrangeColor = numberOfColorChange
            colorGroup.append(contentsOf: getRedToOrangeColor(numberOfColor: numberOfRedToOrangeColor))
        }
        else if percent < 50{
            let numberOfRedToOrangeColor = numberOfColorChange/2
            let numberOfOrangeToYellowColor = numberOfColorChange/2
            
            colorGroup.append(contentsOf: getRedToOrangeColor(numberOfColor: numberOfRedToOrangeColor))
            colorGroup.append(contentsOf: getOrangeToYellowColor(numberOfColor: numberOfOrangeToYellowColor))
        }
        else if percent < 75{
            let numberOfRedToOrangeColor = numberOfColorChange/3
            let numberOfOrangeToYellowColor = numberOfColorChange/3
            let numberOfYellowToLightGreenColor = numberOfColorChange/3
            
            colorGroup.append(contentsOf: getRedToOrangeColor(numberOfColor: numberOfRedToOrangeColor))
            colorGroup.append(contentsOf: getOrangeToYellowColor(numberOfColor: numberOfOrangeToYellowColor))
            colorGroup.append(contentsOf: getYellowToLightGreenColor(numberOfColor: numberOfYellowToLightGreenColor))
        }
        // percent > 75
        else{
            let numberOfRedToOrangeColor = numberOfColorChange/4
            let numberOfOrangeToYellowColor = numberOfColorChange/4
            let numberOfYellowToLightGreenColor = numberOfColorChange/4
            let numberOfLightGreenToGreenColor = numberOfColorChange/4
            
            colorGroup.append(contentsOf: getRedToOrangeColor(numberOfColor: numberOfRedToOrangeColor))
            colorGroup.append(contentsOf: getOrangeToYellowColor(numberOfColor: numberOfOrangeToYellowColor))
            colorGroup.append(contentsOf: getYellowToLightGreenColor(numberOfColor: numberOfYellowToLightGreenColor))
            colorGroup.append(contentsOf: getLightGreenToGreenColor(numberOfColor: numberOfLightGreenToGreenColor))
        }
        
        return colorGroup
        
    }
}
