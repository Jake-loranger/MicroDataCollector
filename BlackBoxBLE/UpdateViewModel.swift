//
//  UpdateViewModel.swift
//  BlackBoxBLE
//
//  Created by Jacob  Loranger on 2/7/23.
//

import Foundation
import UIKit
import CoreData
import SwiftUI

class UpdateViewModel: ObservableObject {
    @Published var index: Int = 0
    @Published var now: Date = Date()
    var timer: Timer?
    var context: NSManagedObjectContext
    var dataSet: [BodyTemp]
    var time: [Date] = []
    var data: [Double] = []
    var dataMin: Double? = 0.0
    var dataMax: Double? = 1000.0
    let formatter = DateFormatter()
    var upperBoundX: Date!
    var lowerBoundX: Date!
    
    init() {
        context = DataController().initContext()
        dataSet = DataController().fetchData(context: context)
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        upperBoundX = formatter.date(from: "2000/01/01 01:01")
        lowerBoundX = formatter.date(from: "2000/01/01 01:01")
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.refresh()})
        
    }
    deinit {
        timer?.invalidate()
    }
    func refresh() {
        context = DataController().initContext()
        dataSet = DataController().fetchData(context: context)
        for item in dataSet {
            data.append(item.data)
            time.append(item.time!)
        }
        
        dataMin = data.min()
        dataMax = data.max()
        
        
        if time.count < 20 {
            upperBoundX = time[time.count-1]
            lowerBoundX = time[0]
        } else {
            upperBoundX = time[time.count-1]
            lowerBoundX = time[time.count-21]
        }
        
        now = Date()
    }
    
}
