import UIKit
import MapKit

class ItineraryViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: ItineraryViewModel?
    let regionRadius: CLLocationDistance = 1000
    var originCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var destinationCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        adjustMapRegion()
        setupAnnotations()
        setupPolyline()
    }
    
    func setupMap() {
        mapView.delegate = self
        self.mapView.isZoomEnabled = true
        guard let vm = viewModel else {
            return
        }
        originCoord = CLLocationCoordinate2D(latitude: vm.getOriginCoords().latitude, longitude: vm.getOriginCoords().longitude)
        
        destinationCoord = CLLocationCoordinate2D(latitude: vm.getDestinationCoords().latitude, longitude: vm.getDestinationCoords().longitude)
    }
    
    func adjustMapRegion() {
        guard let vm = viewModel else {
            return
        }
        var region = MKCoordinateRegion()

        region.center.latitude = vm.getCenter(longitude: false)
        region.center.longitude = vm.getCenter(longitude: true)
        region.span.latitudeDelta = vm.getSpan(x: false)
        region.span.longitudeDelta = vm.getSpan(x: true)
        mapView.setRegion(region, animated: true)
    }
    
    func setupAnnotations() {
        guard let vm = viewModel else {
            return
        }
        let originAnotation = MKPointAnnotation()
        originAnotation.coordinate = originCoord
        originAnotation.title = "departure_airport".localized
        originAnotation.subtitle = vm.getOriginAirportString()
        let destinationAnotation = MKPointAnnotation()
        destinationAnotation.coordinate = destinationCoord
        destinationAnotation.title = "arrival_airport".localized
        destinationAnotation.subtitle = vm.getDestinationAirportString()
        mapView.addAnnotation(originAnotation)
        mapView.addAnnotation(destinationAnotation)
        
    }
    
    func setupPolyline() {
        let polyline = MKGeodesicPolyline(coordinates: [destinationCoord, originCoord], count: 2)
        mapView.addOverlay(polyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.YellowLufthansa
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "1")
        pin.pinTintColor = UIColor.BlueLufthansa
        pin.canShowCallout = true
        return pin
    }

    
    
}
