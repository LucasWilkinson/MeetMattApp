//
//  DataViewController.swift
//  MeetMatt
//
//  Created by Lucas Wiklinson on 2017-02-05.
//  Copyright © 2017 Lucas Wiklinson. All rights reserved.
//

import UIKit
import CorePlot

class GraphController: NSObject, CPTPlotDelegate, CPTPlotDataSource {
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return 0
    }
    
}



class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var hostView: CPTGraphHostingView!
    
    var dataObject: String = ""
    var graphController: GraphController = GraphController()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // 1 - Get a reference to the graph
        let graph = hostView.hostedGraph!
        
        // 2 - Create the chart
        let barPlot = CPTBarPlot()
        barPlot.delegate = graphController
        barPlot.dataSource = graphController
        
        barPlot.identifier = NSString(string: graph.title!)
        
        // 3 - Configure border style
        let borderStyle = CPTMutableLineStyle()
        borderStyle.lineColor = CPTColor.white()
        borderStyle.lineWidth = 2.0
        
        // 4 - Configure text style
        let textStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.white()
        textStyle.textAlignment = .center
        barPlot.labelTextStyle = textStyle
        
        // 5 - Add chart to graph
        graph.add(barPlot)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }


}

