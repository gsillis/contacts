//
//  Localization.swift
//  Agenda
//
//  Created by Gabriela Sillis on 28/06/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import CoreLocation

class Localization: NSObject {
    
    func convertAddress(address: String, local: @escaping(_ local: CLPlacemark) -> Void) {
        let converter = CLGeocoder()
        
        converter.geocodeAddressString(address) { list, error in
            if let locationList = list?.first {
                local(locationList)
            }
        }
    }
}
