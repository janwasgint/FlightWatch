//
//  TypeInterfaceController.swift
//  FlightWatcher
//
//  Created by Jan Wasgint on 23.08.15.
//  Copyright © 2015 JanWasgint. All rights reserved.
//

import WatchKit

class TypeInterfaceController: WKInterfaceController {
    var airport: Airport?
    let AD = ["Arrivals", "Departures"]
    
    @IBOutlet weak var ADTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let airport = context as? Airport {
            self.airport = airport
            setTitle(airport.airportName)
        }
        ADTable.setNumberOfRows(2, withRowType: "TypeRow")
        for i in [0,1] {
            if let row = ADTable.rowController(at: i) as? TypeRow {
                row.ADImage.setImageNamed("\(AD[i]).png")
                row.ADLabel.setText(AD[i])
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if segueIdentifier == "FlightsSelection" {
            return AirportContext(airport: airport!,
                                  showIncoming: rowIndex == 0)
        }
        return nil
    }
}
