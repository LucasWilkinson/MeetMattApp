//
//  DataViewController.swift
//  MeetMatt
//
//  Created by Lucas Wiklinson on 2017-02-05.
//  Copyright © 2017 Lucas Wiklinson. All rights reserved.
//

import UIKit
import CorePlot
import Alamofire

class User {
    
    var name: String = ""
    var id: Int = 0
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let id = json["id"] as? Int
            else { return nil }
        
        self.name = name
        self.id = id
    }
    
}


class DataViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var meetMattLabel: UILabel!
    @IBOutlet weak var hostView: CPTGraphHostingView!
    @IBOutlet weak var userSelector: UIPickerView!
    @IBOutlet weak var filterSelector: UISegmentedControl!
    
    let fake_yData: [Double] = [1,-1,1.2,-1.2,0,-2,3,-2,1,-1, 1,-1, 1,-1]
    let fake_xData: [Double] = [0, 1,  2,   3,4, 5,6, 7,8,10,11,15,16,17]
    
    var users: [User] = []
    var dataObject: String = ""
    var graphController = GraphController()
    
    let plotSpace = CPTXYPlotSpace()

    func requestUsers(){
        Alamofire.request("http://api.meetmatt.ca/public/api/v1/users").validate().responseJSON { response in
            print(response.result)   // result of response serialization
            var userList: [User] = []
            
            if let usersJSON = response.result.value as? [Any]{
                for userJSON in usersJSON {
                    guard let user = User(json: userJSON  as! [String : Any])
                        else{ continue }
                    
                    userList.append(user)
                }
            }
            if (userList.count > 0){
                self.getUserData(id: userList[0].id)
            }
            self.updateUserList(newUserList: userList)
        }
    }
    
    func getUserData(id: Int){
        let idParameter: Parameters = ["user_id": id]
        print("\(idParameter)")
        Alamofire.request("http://api.meetmatt.ca/public/api/v1/interactions", parameters: idParameter).validate().responseJSON { response in
            print(response.result)   // result of response serialization
            //print(response.request)
            //print(response.result.value)
            
            var dataList: [scatterPlotPoint] = []
                
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            //let date = dateFormatter.date(from:isoDate)!
            
            if let dataPointsJSON = response.result.value as? [Any]{
                for dataPoint in dataPointsJSON {
                    guard let data = dataPoint as? [String: Any]
                        else{ print("failed to cast datapoint"); continue }
                    guard let weight = (data["weight"] as? NSString)?.doubleValue
                        else{ print("failed to get weight"); continue }
                    
                    let date = dateFormatter.date(from: data["date_time"] as! String)
                    
                    let tempData = scatterPlotPoint(x: (date?.timeIntervalSince1970)!, y: weight)
                    
                    dataList.append(tempData)
                    
                    //print("\((date?.timeIntervalSince1970)!)")
                }
                self.graphController.setData(data: dataList)
            }
        }
    }
    
    func updateUserList (newUserList: [User]){
        print("updating user list")
        users = newUserList
        userSelector.reloadAllComponents()
    }
    
    
    
    /* -- start Picker view data source and delegate functions */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myLabel.text = users[row].name
        print("selected \(users[row].name)")
        getUserData(id: users[row].id)
    }
    
    /* ---- end Picker view data source and delegate functions */
    
    
    func filterSelected(){
        
        switch(filterSelector.selectedSegmentIndex){
        case 2:
            graphController.setFilter(filterType: .ALL)
            break
        case 1:
            graphController.setFilter(filterType: .MONTH)
            break
        case 0:
            graphController.setFilter(filterType: .WEEK)
            break
        default:
            print("Bad Selection")
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hostView.hostedGraph = graphController.createGraph(frame: hostView.bounds)
        userSelector.dataSource = self
        userSelector.delegate = self
        filterSelector.selectedSegmentIndex = 2
        filterSelector.addTarget(self, action: #selector(filterSelected), for: .valueChanged)
        
        requestUsers()
        
        //graphController.setData(xData: fake_xData, yData: fake_yData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}

