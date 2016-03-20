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
   
 
    
    var points:NSMutableArray?
    var currentLocation:CLLocationCoordinate2D?
    var routerLine:MKPolyline?
    var mapView:MKMapView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
        self.configure()
         self.mapView.frame = view.frame
         view.addSubview(self.mapView)
    }
    
    
    func getMapView(superview:UIView){
        
        self.configure()
        self.mapView.frame = superview.frame
        superview.addSubview(mapView)
    }
    
    
    func configure(){
        
        
        self.mapView = MKMapView()
        self.mapView.delegate = self
        self.mapView.pitchEnabled = false
        self.mapView.userInteractionEnabled = false
        self.mapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading
        self.mapView.mapType = MKMapType.Standard
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        self.mapView.userTrackingMode = MKUserTrackingMode.Follow
        self.mapView.mapType = MKMapType.Standard
        
        
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        
        
        setRegion(userLocation)
      
        
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
      
        if overlay is MKPolyline {
           
            var polylineRenderer = MKPolylineRenderer(polyline: self.routerLine!)
            polylineRenderer.strokeColor = UIColor.greenColor()
            polylineRenderer.lineWidth = 10
            return polylineRenderer
        }
        
       
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
