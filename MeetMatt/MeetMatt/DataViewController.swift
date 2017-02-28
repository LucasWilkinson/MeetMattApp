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

let MeetMattBlue = UIColor(colorLiteralRed: 74/255, green: 130/255, blue: 219/255, alpha: 1.0)


let serverInterface = ServerDataController()

protocol UserSelectorDelegate {
    func usersUpdated()
}

class ServerDataController{
    var userSelectorDelegate : UserSelectorDelegate? = nil
    var appFirstSuccessfulReq = false
    var users: [User] = []
    
    func getUsers()->[User]{
        return users
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
                dataController.setData(data: dataList)
            }
        }
    }
    
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
            
            print("Got users")
            print(userList)
            
            if (!self.appFirstSuccessfulReq && userList.count != 0){
                self.appFirstSuccessfulReq = true
                self.getUserData(id: userList[0].id)
            }
            
            self.userSelectorDelegate?.usersUpdated()
            self.users = userList
        }
    }
}



class UsersViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate, UserSelectorDelegate {
    
    @IBOutlet weak var userSelector: UIPickerView!
    
    func usersUpdated(){
        userSelector.reloadAllComponents()
    }
    
    /* -- start Picker view data source and delegate functions */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serverInterface.getUsers().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let users = serverInterface.getUsers()
        guard (row < users.count) else {return nil}
        
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myLabel.text = users[row].name
        let users = serverInterface.getUsers()
        guard (row < users.count) else {return}
        
        //print("selected \(serverInterface.getUsers()[row].name)")
        serverInterface.getUserData(id: users[row].id)
    }
    
    /* ---- end Picker view data source and delegate functions */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("User view did load")
        
        serverInterface.userSelectorDelegate = self
        
        userSelector.dataSource = self
        userSelector.delegate = self
    }
}

class TargetWeightPickerView: UIView {
    var delegate: TargetWeightPicker? = nil
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        delegate?.viewDidLoad()
    }
}

class TargetWeightPicker: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let screenWidth = UIScreen.main.bounds.width
    let pickerHeight: CGFloat = 200
    let toolBarHeight: CGFloat = 44
    
    let view = TargetWeightPickerView()
    let picker = UIPickerView()
    let toolBar = UIToolbar()
    
    let plusMinusWeightRange = 50
    let defaultWeight = 150
    var weightsToOffer: [Int] = Array(150-50...150+50)
    
    var associatedTextField:UITextField? = nil
    
    override init(){
        super.init()
        
        picker.frame = CGRect(x: CGFloat(0), y: toolBarHeight, width: screenWidth, height: pickerHeight)
        toolBar.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: screenWidth, height: toolBarHeight)

        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        
        let barButtonDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done(_:)))
        barButtonDone.tintColor = MeetMattBlue
        
        let barButtonCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        barButtonCancel.tintColor = MeetMattBlue
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.barStyle = .default
        toolBar.items = [barButtonCancel, flexibleSpace, barButtonDone]
        
        let targetWeightPickerViewFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: screenWidth, height: toolBarHeight + pickerHeight)
        view.frame = targetWeightPickerViewFrame
        
        view.addSubview(picker)
        view.addSubview(toolBar)
        
        view.delegate = self
    }
    
    func viewDidLoad(){
        print("Loaded picker")
        
        var currentWeight = dataController.getMostRecentWeight()
        if currentWeight == nil {
            currentWeight = Double(defaultWeight)
        }
        
        let currentWeightInt = Int(currentWeight!.rounded())
        weightsToOffer = Array(currentWeightInt-plusMinusWeightRange...currentWeightInt+plusMinusWeightRange)
        
        picker.reloadAllComponents()
        picker.selectRow(weightsToOffer.count/2, inComponent: 0, animated: false)
    }
    
    
    func done(_ sender: TargetWeightPicker){
        associatedTextField?.text = String(weightsToOffer[picker.selectedRow(inComponent: 0)])
        associatedTextField?.resignFirstResponder()
    }
    
    func cancel(_ sender: TargetWeightPicker){
        associatedTextField?.resignFirstResponder()
    }
    
    /* -- start Picker view data source and delegate functions */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //print("getting components"
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print("getting values")
        return weightsToOffer.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (weightsToOffer[row] as NSNumber).stringValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("selected Row \(row)")
    }
    
    /* ---- end Picker view data source and delegate functions */
}

class DataViewController: UIViewController {

    @IBOutlet weak var hostView: CPTGraphHostingView!
    @IBOutlet weak var filterSelector: UISegmentedControl!
    //@IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var targetWeight: UITextField!
    
    @IBAction func refresh(_ sender: Any) {
        serverInterface.requestUsers()
    }

    let graphController = GraphController()
    var dataObject: String = ""
    
    let plotSpace = CPTXYPlotSpace()
    let targetWeightPicker = TargetWeightPicker()
    
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

        print("Data view did load")
        
        hostView.hostedGraph = graphController.createGraph(frame: hostView.bounds)
        filterSelector.selectedSegmentIndex = 2
        filterSelector.addTarget(self, action: #selector(filterSelected), for: .valueChanged)
        
        targetWeightPicker.associatedTextField = targetWeight
        targetWeight.inputView = targetWeightPicker.view
    
        dataController.associatedGraphControllers.append(graphController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = MeetMattBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}

