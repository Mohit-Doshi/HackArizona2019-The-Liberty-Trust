//
//  MapsViewController.swift
//  HackArizona_19
//
//  Created by Mohit on 20/01/19.
//  Copyright © 2019 Mohit D. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var coords:CLLocationCoordinate2D?
    var keyw:String?
    var locationManager = CLLocationManager()
    
    var pointAnnotation:CustomPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        if(CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        map.delegate = self as! MKMapViewDelegate
        map.mapType = MKMapType.standard
        map.showsUserLocation = true
        self.loadplaces()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let currloc:CLLocationCoordinate2D = manager.location!.coordinate
        self.coords = currloc
        let coordinates = CLLocationCoordinate2D( latitude: (currloc.latitude), longitude: (currloc.longitude))
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
        self.map.setRegion(region, animated: true)

        
        pointAnnotation = CustomPointAnnotation()
        pointAnnotation.pinCustomImageName = "PiazzaTime"
        pointAnnotation.coordinate = currloc
        pointAnnotation.title = "YOU<3"
        pointAnnotation.subtitle = "LIST OF PLACES:-"
        
    }
    
    func loadplaces()
    {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.keyw
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        var points:[CLLocationCoordinate2D] = []
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems

//            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: "pin")
//            self.map.addAnnotation(self.pinAnnotationView.annotation!)
            
            
            
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                print(place.location?.coordinate.latitude)
                print(place.location?.coordinate.longitude)
                print(place.name)
                
                points.append((place.location?.coordinate)!)
                
                
                let ani = MKPointAnnotation()
                //   if(tempcoordinates != nil) {
                ani.coordinate.latitude = place.location?.coordinate.latitude ?? 0
                ani.coordinate.longitude = place.location?.coordinate.longitude ?? 0
                print("ani.coordinate is", ani.coordinate)
                ani.title = place.name
                ani.subtitle = self.keyw
                self.map.addAnnotation(ani)
                
                
            }
            
            
            let polygon = MKPolygon(coordinates: &points, count: points.count)
            
            self.map.addOverlay(polygon)
            
        }
    }
    
   
   
    
    
    
    



func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!
{
    if overlay is MKPolygon {
        let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.strokeColor = UIColor.magenta
        
        return polygonView
    }
    let polygonView = MKPolygonRenderer(overlay: overlay)
    return polygonView
}

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
