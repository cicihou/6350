//
//  ViewController.swift
//  Tourist
//
//  Created by ccc on 9/24/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let place = ["Paris", "Rome", "Seattle", "Spain", "Vegas"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = place[indexPath.row]
        let cell = Bundle.main.loadNibNamed("PlaceTableViewCell", owner: self)?.first as! PlaceTableViewCell
        cell.img.image = UIImage(named: place[indexPath.row])
        cell.lbl.text = place[indexPath.row]

        return cell
    }

}

