import Foundation
import GoogleMaps
import UIKit
import GoogleMapsUtils

class HeatmapViewController: UIViewController, GMSMapViewDelegate {
  private var mapView: GMSMapView!
  private var heatmapLayer: GMUHeatmapTileLayer!
  private var button: UIButton!

    private var gradientColors = [UIColor.clear, UIColor.green, UIColor.yellow, UIColor.yellow, UIColor.orange, UIColor.orange, UIColor.red, UIColor.purple]
    
    private var gradientStartPoints = [0.1, 0.2, 0.3, 0.4, 0.5, 0.7, 0.8, 0.9] as [NSNumber]

  override func loadView() {
    let camera = GMSCameraPosition.camera(withLatitude: 49.612082, longitude: 6.129571, zoom: 15)
    mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView.delegate = self
    self.view = mapView
    makeButton()
  }

  override func viewDidLoad() {
    // Set heatmap options.
    heatmapLayer = GMUHeatmapTileLayer()
    heatmapLayer.radius = 100
    heatmapLayer.opacity = 1
    heatmapLayer.maximumZoomIntensity = 40
    heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                        startPoints: gradientStartPoints,
                                        colorMapSize: 256)
    addHeatmap()

    // Set the heatmap to the mapview.
    heatmapLayer.map = mapView
  }

  // Parse JSON data and add it to the heatmap layer.
  func addHeatmap()  {
    var list = [GMUWeightedLatLng]()
    do {
      // Get the data: latitude/longitude positions of police stations.

        let file = "file.txt"

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            
            //reading
            do {
                let data = try Data(contentsOf: fileURL)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [[String: Any]] {
                  for item in object {
                    let lat = item["lat"]
                    let lng = item["lng"]
                    let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: item["currentpopular"] as! Float / 100)
                    
                    list.append(coords)
                  }
                } else {
                  print("Could not read the JSON.")
                }
            }
            catch {/* error handling here */}
        }
    } catch {
      print(error.localizedDescription)
    }
    // Add the latlngs to the heatmap layer.
    heatmapLayer.weightedData = list
  }

  @objc
  func removeHeatmap() {

  }

  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
  }

  // Add a button to the view.
  func makeButton() {

  }
}
