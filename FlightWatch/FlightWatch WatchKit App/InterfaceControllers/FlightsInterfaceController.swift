//
//  TypeInterfaceController.swift
//  FlightWatcher
//
//  Created by Jan Wasgint on 23.08.15.
//  Copyright © 2015 JanWasgint. All rights reserved.
//

import WatchKit

class FlightsInterfaceController: WKInterfaceController {
    let dateFormat = "h:mm a"
    var flights: [Flight]?
    var showIncoming: Bool = false
    
    @IBOutlet var flightsTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let airportContext = context as? AirportContext {
            self.flights = airportContext.showIncoming ?
                airportContext.airport.incomingFlights :
                airportContext.airport.outgoingFlights
            setTitle(airportContext.airport.airportName)
            self.showIncoming = airportContext.showIncoming
            reloadTable()
        }
    }
    
    private func reloadTable() {
        guard let flights = self.flights else { return }
        flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
        for i in 0..<flights.count {
            if let row = flightsTable.rowController(at: i) as? FlightRow {
                row.cityLabel.setText(showIncoming ? flights[i].fromCity : flights[i].toCity)
                row.timeLabel.setText(getFormattedDateAsString(date: flights[i].expectedTime))
                row.flightCodeLabel.setText(flights[i].flightCode)
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if segueIdentifier == "FlightDetails" {
            return flights?[rowIndex]
        }
        return nil
    }
        
    private func getFormattedDateAsString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
