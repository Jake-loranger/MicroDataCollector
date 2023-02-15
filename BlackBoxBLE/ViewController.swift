//
//  ViewController.swift
//  BlackBoxBLE
//
//  Created by Jacob  Loranger on 1/19/23.
//

import UIKit
import CoreBluetooth
import Foundation
import CoreData
import SwiftUI

class ViewController: UIViewController, UITableViewDataSource, ObservableObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tempData = [BodyTemp]()
    var bluetooth = BluetoothViewModel()

    @IBOutlet weak var bleStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTableView.dataSource = self
    }
    
    
    // Intiates BLE connection when button is pressed
    @IBAction func connectBluetooth(_ sender: Any) {
        
        print("connecting...")
    
        bluetooth.setup()
        
        if bluetooth.bleStatus == true {
            //Changes button appearance based on status
            self.bleStatus.text = "Status: Connected"
            print("bluetooth connected")
        }
        else {
            //Reverts to original button appearance
            print("bluetooth not connected")
            self.bleStatus.text = "Status: Not Connected"
        }
    }
    
//    Adds button that updates data
    @IBAction func refreshData(_ sender: Any) {
        tempData = fetch()
        self.dataTableView.reloadData()
    }
    
//    Adds button that deletes data
    @IBAction func deleteData(_ sender: Any) {
        deleteCoreData()
        tempData = fetch()
        self.dataTableView.reloadData()
    }
    
    
    @IBAction func openGraphView(_ sender: Any) {
        let graphView = ChartView()
        let graphVC = UIHostingController(rootView: graphView)
        self.present(graphVC, animated: true)
    }
    
    
    
    
//    Retrieve data from BluetoothViewModel via CoreData
    
    func fetch() -> [BodyTemp] {
        do {
            tempData = try context.fetch(BodyTemp.fetchRequest())
        } catch {
            print("couldnt fetch")
        }
        return tempData
    }

//     Create a function to delete data for testing
    func deleteCoreData() {
        do {
            tempData = try context.fetch(BodyTemp.fetchRequest())
            for i in 0...tempData.count-1 {
                self.context.delete(tempData[i] as BodyTemp)
            }
            do {
                try self.context.save()
            }
            catch {
            }
            tempData = fetch()
        }
        catch {
        }
    }
    
    
//     Display data in a UIViewTable
    
    @IBOutlet weak var dataTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let dataPoints = tempData[indexPath.row]
        
//        dataPoint.temp = Int64(tempPoint)
        
        let tempData = dataPoints.data
        let tempDataString = String(tempData)
        cell.textLabel?.text = tempDataString as! String
        
        let tempDate = dataPoints.time as! Date
        let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MMMM d yyyy, hh:mm:ss"
        
        cell.detailTextLabel?.text = dateFormatter.string(from: tempDate)
        
        return cell
    }
    
    
    // Gather data to display in SwiftCharts
    
}


