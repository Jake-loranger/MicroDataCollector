//
//  FindMinMax.swift
//  BlackBoxBLE
//
//  Created by Jacob  Loranger on 2/7/23.
//

import Foundation
import UIKit
import CoreData

func FindMinMax(data: [Double]) -> (Double, Double) {
    var min: Double = data.min() ?? -1
    var max: Double = data.max() ?? -1
    
    
    return(min,max)
}
