//
//  MapViewController.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/13.
//  Copyright © 2016年 ccsu. All rights reserved.
//


import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate {
   
  private  var points:NSMutableArray?
    private  var currentLocation:CLLocationCoordinate2D?
    private var routerLine:MKPolyline?
    
    
    var mapView:MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView = MKMapView()
        self.mapView.frame = view.frame
        self.mapView.delegate = self
        self.mapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading
        self.mapView.mapType = MKMapType.Standard
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        self.mapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading
        self.mapView.mapType = MKMapType.Standard
        view.addSubview(self.mapView)
    }

    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        print(userLocation.location?.coordinate.latitude)
        print(userLocation.location?.coordinate.longitude)
        setRegion(userLocation)
        print("------------Map---------")
        
       self.currentLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        if self.points == nil {
            self.points = NSMutableArray()
            
        }
        self.points?.addObject(userLocation)
        self.routerLine = self.polyline()
        if self.routerLine != nil {
            self.mapView.addOverlay(self.routerLine!)
        }
        
        
        
        
    }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        print("__________________Overlay________")
        if overlay is MKPolyline {
           
            var polylineRenderer = MKPolylineRenderer(polyline: self.routerLine!)
            polylineRenderer.strokeColor = UIColor.redColor()
            polylineRenderer.lineWidth = 10
            return polylineRenderer
        }
        
        print("else")
        return MKOverlayRenderer()
    }
    
    
    func polyline()->MKPolyline{
     
        var coords = [CLLocationCoordinate2D]()
        for var i = 0; i<self.points?.count;i++ {
            var userLocation = self.points?.objectAtIndex(i) as! MKUserLocation
            let c = userLocation.coordinate
            coords.append(c)
            
            
        }
        return MKPolyline(coordinates: &coords, count: self.points!.count)
        
    }

    
    func setRegion(center:MKUserLocation){
        
        self.mapView.region =  MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: center.coordinate.latitude, longitude: center.coordinate.longitude), 2000, 2000)
        
        
    }
    
    
 

}
