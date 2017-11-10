//
//  InterfaceController.swift
//  FlightWatcher WatchKit 1 Extension
//
//  Created by Jan Wasgint on 22.08.15.
//  Copyright © 2015 JanWasgint. All rights reserved.
//

import WatchKit

class AirportInterfaceController: WKInterfaceController {

    @IBOutlet var airportTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("FlightWatcher")
        airportTable.setNumberOfRows(airports.count, withRowType: "AirportNameRow")
        for i in 0..<airports.count {
            if let row = airportTable.rowController(at: i) as? AirportNameRow {
                row.airportNameLabel.setText(airports[i].airportName)
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if segueIdentifier == "TypeSelection" {
            let airport = airports[rowIndex]
            return airport
        }
        return nil
    }
}
