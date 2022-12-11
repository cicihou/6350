//
//  DetailsViewController.swift
//  GetStockPrices
//
//  Created by Drillmaps on 10/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import CoreLocation

class DetailsViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var globalSymbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getValues()
        // Do any additional setup after loading the view.
    }
    
    func getValues(){
        var url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/getstock?symbol="
        url += globalSymbol
        
        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            
            let stockData = JSON(responseData.data as Any)
            self.name.text = "Company Name: \(stockData["CompanyName"].stringValue)"
            self.symbol.text = "Company Symbol: \(stockData["Symbol"].stringValue)"
            self.price.text = "Stock Price: \(stockData["Price"].floatValue) $"

        }
    }

}
