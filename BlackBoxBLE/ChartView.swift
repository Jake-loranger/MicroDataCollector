//
//  GraphViewController.swift
//  BlackBoxBLE
//
//  Created by Jacob  Loranger on 1/24/23.
//

import SwiftUI
import Charts
import CoreData
import UIKit



struct ChartView: View {
    let title: String = "Body Temperature"
    var context: NSManagedObjectContext
    var tempData: [BodyTemp]
    @StateObject var updateViewModel = UpdateViewModel()
    @State var start = Date()
    
    
    
    init() {
        context = DataController().initContext()
        tempData = DataController().fetchData(context: context)
        updateViewModel.dataSet = tempData
    }
    
    var body: some View {
        GroupBox ("Body Temperature") {
            Chart {
                ForEach(updateViewModel.dataSet) { item in
                    LineMark(
                        x: .value("Time", item.time!),
                        y: .value("Temp", item.data)
                    ).interpolationMethod(.catmullRom)
                }
                ForEach(updateViewModel.dataSet) { item in
                    AreaMark(
                        x: .value("Time", item.time!),
                        yStart: .value("Temp Min", 1700),
                        yEnd: .value("Temp Max", 1750)
                    )
                    .opacity(0.1)

                }
            }
            .chartYScale(domain: (updateViewModel.dataMin!*0.9)...(updateViewModel.dataMax!*1.1))
            .chartXScale(domain: (updateViewModel.lowerBoundX!) ... (updateViewModel.upperBoundX!))
            .chartYAxis{
                AxisMarks(preset: .automatic, position: .leading)
            }
            .chartXAxis{
                AxisMarks(preset: .automatic, position: .automatic)
                
            }
        }
        
        VStack {
            List {
                ForEach(updateViewModel.dataSet) {item in
                    Text(String(item.data))
                }
            }
        }.navigationTitle("Raw Data")
    }
    
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

