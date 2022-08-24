//
//  CLLocationCoordinate2D+SQDevKit.swift
//  SQLists
//
//  Created by Aleksandr Rudikov on 22.08.2022.
//

import Foundation
import CoreLocation
import SwiftyJSON

public extension CLLocationCoordinate2D {

    init?(withJson json: JSON) {
        guard let latitude = json["latitude"].double,
              let longitude = json["longitude"].double else {
            return nil
        }

        self.init(latitude: latitude, longitude: longitude)
    }
}
