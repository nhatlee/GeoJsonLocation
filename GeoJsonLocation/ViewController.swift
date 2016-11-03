//
//  ViewController.swift
//  GeoJsonLocation
//
//  Created by lee on 11/3/16.
//  Copyright © 2016 com.acc.siridemo. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet var mapboxView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapboxView = MGLMapView(frame: view.bounds)
        mapboxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapboxView.setCenter(CLLocationCoordinate2D(latitude: 45.5076, longitude: -122.6736),
                                    zoomLevel: 11, animated: false)
        view.addSubview(self.mapboxView)
        
        mapboxView.delegate = self
        mapboxView.allowsZooming = true
        
//        drawPolyline()
        newWay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawPolyline() {
        
        // Parsing GeoJSON can be CPU intensive, do it on a background thread
        DispatchQueue.global(qos: .background).async {
            // Get the path for example.geojson in the app's bundle
            let jsonPath = Bundle.main.path(forResource: "KMLMAPNew", ofType: "json")
            let jsonData = NSData(contentsOfFile: jsonPath!)
            
            do {
                // Load and serialize the GeoJSON into a dictionary filled with properly-typed objects
                guard let jsonDict = try JSONSerialization.jsonObject(with: jsonData! as Data, options: []) as? Dictionary<String, AnyObject>, let features = jsonDict["features"] as? Array<AnyObject> else{return}
                
                for feature in features {
                    guard let feature = feature as? Dictionary<String, AnyObject>, let geometry = feature["geometry"] as? Dictionary<String, AnyObject> else{ continue }
                    
                    if geometry["type"] as? String == "LineString" {
                        // Create an array to hold the formatted coordinates for our line
                        var coordinates: [CLLocationCoordinate2D] = []
                        
                        if let locations = geometry["coordinates"] as? Array<AnyObject> {
                            // Iterate over line coordinates, stored in GeoJSON as many lng, lat arrays
                            for location in locations {
                                // Make a CLLocationCoordinate2D with the lat, lng
                                if let location = location as? Array<AnyObject>{
                                    let coordinate = CLLocationCoordinate2DMake(location[1].doubleValue, location[0].doubleValue)
                                    
                                    // Add coordinate to coordinates array
                                    coordinates.append(coordinate)
                                }
                            }
                        }
                        
                        let line = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
                        
                        // Optionally set the title of the polyline, which can be used for:
                        //  - Callout view
                        //  - Object identification
                        line.title = "Crema to Council Crest"
                        
                        // Add the annotation on the main thread
                        DispatchQueue.main.async {
                            // Unowned reference to self to prevent retain cycle
                            [unowned self] in
                            self.mapboxView.addAnnotation(line)
                        }
                    }
                }
            }
            catch
            {
                print("GeoJSON parsing failed")
            }
        }
    }
    
    
    
    func newWay(){
        
        // Parsing GeoJSON can be CPU intensive, do it on a background thread
        DispatchQueue.global(qos: .background).async {
            // Get the path for example.geojson in the app's bundle
            let jsonPath = Bundle.main.path(forResource: "KMLMAPNew", ofType: "json")
            let jsonData = NSData(contentsOfFile: jsonPath!)
            
            do {
                // Load and serialize the GeoJSON into a dictionary filled with properly-typed objects
                if let jsonDict = try JSONSerialization.jsonObject(with: jsonData! as Data, options: []) as? Dictionary<String, AnyObject> {
                    
                    // Load the `features` array for iteration
                    if let features = jsonDict["features"] as? Array<AnyObject> {
                        let chunks = stride(from: 0, to: features.count, by: 2).map {
                            Array(features[$0..<min($0 + 2, features.count)])
                        }
                        for obj in chunks{
//                            print(obj)
                            self.drawSmallListObj(list: obj as! [Dictionary<String, AnyObject>])
                        }
                        
                        
                        
//                        for feature in features {
//                            if let feature = feature as? Dictionary<String, AnyObject> {
//                                if let geometry = feature["geometry"] as? Dictionary<String, AnyObject> {
//                                    if geometry["type"] as? String == "LineString" {
//                                        // Create an array to hold the formatted coordinates for our line
//                                        var coordinates: [CLLocationCoordinate2D] = []
//                                        
//                                        if let locations = geometry["coordinates"] as? Array<AnyObject> {
//                                            // Iterate over line coordinates, stored in GeoJSON as many lng, lat arrays
//                                            for location in locations {
//                                                // Make a CLLocationCoordinate2D with the lat, lng
//                                                if let location = location as? Array<AnyObject>{
//                                                    let coordinate = CLLocationCoordinate2DMake(location[1].doubleValue, location[0].doubleValue)
//                                                    
//                                                    // Add coordinate to coordinates array
//                                                    coordinates.append(coordinate)
//                                                }
//                                            }
//                                        }
//                                        
//                                        let line = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
//                                        
//                                        // Optionally set the title of the polyline, which can be used for:
//                                        //  - Callout view
//                                        //  - Object identification
//                                        line.title = "Crema to Council Crest"
//                                        
//                                        // Add the annotation on the main thread
//                                        DispatchQueue.main.async {
//                                            // Unowned reference to self to prevent retain cycle
//                                            [unowned self] in
//                                            self.mapboxView.addAnnotation(line)
//                                        }
//                                    }
//                                }
//                            }
//                        }
                    }
                }
            }
            catch
            {
                print("GeoJSON parsing failed")
            }
        }
    }
    
    
    func drawSmallListObj(list: [Dictionary<String, AnyObject>]){
        for obj in list{
//            print(obj)
            if let feature = obj as? Dictionary<String, AnyObject> {
                if let geometry = feature["geometry"] as? Dictionary<String, AnyObject> {
                    if geometry["type"] as? String == "LineString" {
                        // Create an array to hold the formatted coordinates for our line
                        var coordinates: [CLLocationCoordinate2D] = []
                        
                        if let locations = geometry["coordinates"] as? Array<AnyObject> {
                            // Iterate over line coordinates, stored in GeoJSON as many lng, lat arrays
                            for location in locations {
                                // Make a CLLocationCoordinate2D with the lat, lng
                                if let location = location as? Array<AnyObject>{
                                    let coordinate = CLLocationCoordinate2DMake(location[1].doubleValue, location[0].doubleValue)
                                    
                                    // Add coordinate to coordinates array
                                    coordinates.append(coordinate)
                                }
                            }
                        }
                        
                        let line = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
                        
                        // Optionally set the title of the polyline, which can be used for:
                        //  - Callout view
                        //  - Object identification
                        line.title = "Crema to Council Crest"
                        
                        // Add the annotation on the main thread
                        DispatchQueue.main.async {
                            // Unowned reference to self to prevent retain cycle
                            [unowned self] in
                            self.mapboxView.addAnnotation(line)
                        }
                    }
                }
            }
        }
    }
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        // Set the alpha for all shape annotations to 1 (full opacity)
        return 1
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 2.0
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        // Give our polyline a unique color by checking for its `title` property
        if (annotation.title == "Crema to Council Crest" && annotation is MGLPolyline) {
            // Mapbox cyan
            return UIColor(red: 59/255, green:178/255, blue:208/255, alpha:1)
        }
        else
        {
            return UIColor.red
        }
    }


}

