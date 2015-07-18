//
//  ViewController.swift
//  Where Am I
//
//  Created by Shaowei Zhang on 15/7/18.
//  Copyright © 2015年 Shaowei Zhang. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        manager = CLLocationManager()
        self.manager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        let userLocation:CLLocation = locations[0] as CLLocation
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        self.courseLabel.text =  "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:{ (placemarks, error) -> Void in
            if (error != nil){
                print(error)
            } else {
                if let p = CLPlacemark(placemark: placemarks![0] as? CLPlacemark) {
                    //                    print(p)
                    if(p.subThoroughfare != nil){
                        self.addressLabel.text = "\(p.subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.country)  \(p.postalCode)"
                    }else{
                        self.addressLabel.text = "\(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.country)  \(p.postalCode)"
                    }
                }
            }
        })
        
        
    }
}

