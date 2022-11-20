//
//  ViewController.swift
//  WeatherForcast
//
//  Created by ccc on 11/19/22.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    
    let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    var arr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
        
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func getCityWeather(_ sender: Any) {
        self.arr = [String]()
//        let cityName = txtCity.text
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC&locations="
        url += txtCity.text!
        
        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            
            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][self.txtCity.text!]["values"]
            print(forecastValues.count)
            
            for forecast in forecastValues {
                
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "Temperature = \(temp) F, \(condition)"
                self.arr.append(str)
                print(temp)
            }
            self.tblView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                    cell.textLabel?.text = arr[indexPath.row]
                    return cell
    }
    
    
    @IBAction func func1(_ sender: Any) {
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC&locations="
        url += String(format: "%f", lat!) + "," + String(format: "%f", lon!)
        //        url += txtCity.text!
        
        AF.request(url).responseJSON { responseData in

            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            
            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][String(format: "%f", self.lat!) + "," + String(format: "%f", self.lon!)]["values"]
            print(forecastValues.count)
            
            for forecast in forecastValues {
                
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "Temperature = \(temp) F, \(condition)"
                self.arr.append(str)
                print(temp)
            }
        }
       
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return arr.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = arr[indexPath.row]
//            return cell
//        }
        
    }
}
