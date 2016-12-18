//
//  ViewController.swift
//  pPoint
//
//  Created by jianhao on 2016/12/18.
//  Copyright © 2016年 cocoaswifty. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

struct Element {
    var name: String
    var detail: String
    var image: UIImage
}

extension Element {

//    /// Load all the elements from the plist file
//    static func loadFromPlist() throws -> [Element] {
//        // First we need to find the plist
//        guard let file = Bundle.main.path(forResource: "Elements", ofType: "plist") else {
//            
//        }
//    }
    
    static func loadData(dic: [String:String]) -> [Element] {
        var elements: [Element] = []
        let element: Element = Element(name: dic["name"]!,
                                       detail: dic["detail"]!,
                                       image: UIImage(named: dic["image"]!)!)
        elements.append(element)
        
        return elements
    }
}

class ViewController: UIViewController {
    @IBOutlet var bannerView: GADBannerView!
    
//    var elements: [Element] = []
    
    let elements = Element.loadData(dic: ["name":"抽獎", "detail":"點擊抽獎", "image":"menu"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bannerView.adUnitID = "ca-app-pub-4693782726428989/9364322089"//"ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
        FIRAnalytics.logEvent(withName: kFIREventSelectContent, parameters: [
            kFIRParameterContentType:"cont" as NSObject,
            kFIRParameterItemID:"1" as NSObject
            ])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = elements[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        // Adding the right informations
        cell.textLabel?.text = element.name
        cell.detailTextLabel?.text = element.detail
        cell.imageView?.image = element.image
        
        // Returning the cell
        return cell
    }
}




