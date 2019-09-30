//
//  ViewController.swift
//  MapKitTest02
//
//  Created by D7703_15 on 2019. 9. 16..
//  Copyright © 2019년 bohyun. All rights reserved.
//

import UIKit
import MapKit

class ViewPoint: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class ViewController: UIViewController, MKMapViewDelegate {
    
    // 배열 선언
    var pins = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        // MapType 설정 (standard, hybrid, satellite)
        mapView.mapType = MKMapType.standard
        
        //지도의 center, region, Map 설정
        zoomToRegion()
        
        // pin꼽기
        let pin1 = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.166197, longitude: 129.072594), title: "동의과학대학교", subtitle: "We Are DIT")
        let pin2 = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.1681824, longitude: 129.0556455), title: "부산시민공원", subtitle: "부산의 시민공원")
        let pin3 = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.147919, longitude: 129.130123), title: "광안대교", subtitle: "부산의 핫플레이스")
        let pin4 = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.0517554, longitude: 129.0856113), title: "태종대", subtitle: "부산의 관광명소(절벽 위 공원)")
        
        // mapView의 모든 pin들을 나타냄(배열)
        mapView.addAnnotations([pin1, pin2, pin3, pin4])
        
        // MKMapViewDelegate와 UIViewController(self)
        mapView.delegate = self
    }
    
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 35.166197, longitude: 129.072594)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 2000.0, longitudinalMeters: 4000.3)
        mapView.setRegion(region, animated: true)
    }
    
    // MapType 버튼 설정 (standard, hybrid, satellite)
    @IBAction func standardTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.standard
    }
    
    @IBAction func hybridTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    
    @IBAction func satelliteTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    
    
    // MKMapViewDelegate 메소드
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // pin의 재활용
        let identifier = "RE"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        // 재활용할 pin이 없으면 pin 생성
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            //annotationView?.pinTintColor = UIColor.blue   // pin 색깔 변경
            annotationView?.animatesDrop = true
            
            // 오른쪽 : 상세정보 버튼
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            annotationView?.annotation = annotation
        }
        
        // 왼쪽 : 이미지 넣기
        var imgV = UIImageView()
        
        // pin색깔, 이미지 변경
        if annotation.title! == "동의과학대학교"  {
            annotationView?.pinTintColor = UIColor.red
            imgV = UIImageView(image: UIImage(named: "dit.png"))
        } else if annotation.title! == "부산 시민공원"  {
            annotationView?.pinTintColor = UIColor.green
            imgV = UIImageView(image: UIImage(named: "cat.jpg"))
        } else if annotation.title! == "광안대교"  {
            annotationView?.pinTintColor = UIColor.blue
            imgV = UIImageView(image: UIImage(named: "광안대교.png"))
        } else {
            annotationView?.pinTintColor = UIColor.yellow
            imgV = UIImageView(image: UIImage(named: "태종대.png"))
        }
        
        imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        annotationView?.leftCalloutAccessoryView = imgV
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: (view.annotation?.title)!, message: (view.annotation?.subtitle)!, preferredStyle: .alert)
        
        // 확인 버튼
        let ok = UIAlertAction(title:"확인", style: .default)
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(ok)
        
        // 알림창 실행
        self.present(alert, animated: false)
        
    }
}

