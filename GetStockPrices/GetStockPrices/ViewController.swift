//
//  ViewController.swift
//  GetStockPrices
//
//  Created by Drillmaps on 10/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tblView: UITableView!
    
    var arr = [String]()
    var globalSymbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"
        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            
            let stockData = JSON(responseData.data as Any)
            print(stockData)
            
            for stock in stockData {
                let s = JSON(stock.1)
                let company = s["CompanyName"].stringValue
                let symbol = s["Symbol"].stringValue
                let price = s["Price"].floatValue
                let str = "\(company)(\(symbol)): \(price) $"
                self.arr.append(str)
                print(str)
            }
            self.tblView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let string = arr[indexPath.row]
        var sym = string.split(separator: "(")
        sym = sym[1].split(separator: ")")
        globalSymbol = String(sym[0])
        // Send the symbol  to next VC
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if(segue.identifier == "segueDetails"){

                let destVC = segue.destination as! DetailsViewController

                destVC.globalSymbol = globalSymbol

            }

        }

}

