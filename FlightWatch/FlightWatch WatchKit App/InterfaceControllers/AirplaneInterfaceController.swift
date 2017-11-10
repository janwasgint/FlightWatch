//
//  PlaneInterfaceController.swift
//  FlightWatcher
//
//  Created by Jan Wasgint on 24.08.15.
//  Copyright © 2015 JanWasgint. All rights reserved.
//

import WatchKit

class AirplaneInterfaceController: WKInterfaceController {
    @IBOutlet var airplaneImage: WKInterfaceImage!
    @IBOutlet var airplaneName: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let airplane = context as? Airplane {
            airplaneImage.setImageNamed(airplane.airplaneImageName)
            airplaneName.setText(airplane.airplaneName)
            setTitle(airplane.airplaneName)
        }
    }
}
