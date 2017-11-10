//
//  DetailsInterfaceController.swift
//  FlightWatcher
//
//  Created by Jan Wasgint on 24.08.15.
//  Copyright © 2015 JanWasgint. All rights reserved.
//

import WatchKit

enum DetailDataKeys {
    static let dateKey = "FlightDate"
    static let codeKey = "FlightCode"
    static let fromCityKey = "FromCity"
    static let toCityKey = "ToCity"
    static let plannedTimeKey = "PlannedTime"
    static let expectedTimeKey = "ExpectedTime"
    static let terminalAreaKey = "TerminalArea"
    static let flightStateKey = "FlightState"
    
    static let order = [dateKey, codeKey, fromCityKey, toCityKey, plannedTimeKey, expectedTimeKey, terminalAreaKey, flightStateKey];
}

class DetailsInterfaceController: WKInterfaceController {
    let dateFormat = "dd.MM.yyyy"
    let timeFormat = "h:mm a"
    var flight: Flight? {
        didSet {
            guard let flight = self.flight else {
                return
            }
            detailData[DetailDataKeys.dateKey] = getFormattedDateAsString(date: flight.expectedTime, format: dateFormat)
            detailData[DetailDataKeys.codeKey] = flight.flightCode
            detailData[DetailDataKeys.fromCityKey] = flight.fromCity
            detailData[DetailDataKeys.toCityKey] = flight.toCity
            detailData[DetailDataKeys.plannedTimeKey] = getFormattedDateAsString(date: flight.plannedTime, format: timeFormat)
            detailData[DetailDataKeys.expectedTimeKey] = getFormattedDateAsString(date: flight.expectedTime, format: timeFormat)
            detailData[DetailDataKeys.terminalAreaKey] = flight.terminalArea
            detailData[DetailDataKeys.flightStateKey] = flight.flightState
        }
    }
    var detailData = [String : String]()
    let infoLabelData = [
        DetailDataKeys.dateKey : "Date:",
        DetailDataKeys.codeKey : "Code:",
        DetailDataKeys.fromCityKey : "From:",
        DetailDataKeys.toCityKey : "To:",
        DetailDataKeys.plannedTimeKey : "Planned:",
        DetailDataKeys.expectedTimeKey : "Expect.:",
        DetailDataKeys.terminalAreaKey : "Area:",
        DetailDataKeys.flightStateKey : "State:"
    ]
    
    @IBOutlet var detailsTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let flight = context as? Flight {
            self.flight = flight
            setTitle(flight.flightCode)
            detailsTable.setNumberOfRows(infoLabelData.count, withRowType: "DetailsRow")
            
            for i in 0..<infoLabelData.count {
                if let row = detailsTable.rowController(at: i) as? DetailsRow {
                    row.infoLabel.setText(infoLabelData[DetailDataKeys.order[i]])
                    row.dataLabel.setText(detailData[DetailDataKeys.order[i]])
                }
            }
        }
    }

    private func getFormattedDateAsString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        if (segueIdentifier == "AirplaneDetails") {
            return flight?.airplane
        }
        return nil
    }
}
