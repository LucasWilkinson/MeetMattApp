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
    
    let fakeData: [Double] = [1,-1,1.2,-1.2,0,-2,3,-2,1,-1,1,-1,1,-1]
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(fakeData.count)
    }
    
    func double(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Double {
        print("---------")
        if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.X){
            print("x \(idx)")
            return Double(idx)
        }else if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.Y){
            print("y \(fakeData[Int(idx)])")
            return fakeData[Int(idx)]
        }else{
            print("??????")
            return 0
        }
    }
    
}



class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var hostView: CPTGraphHostingView!
    
    var dataObject: String = ""
    var graphController: GraphController = GraphController()
    
    let plotSpace = CPTXYPlotSpace()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 1 - Get a reference to the graph
        let graph = CPTXYGraph(frame: hostView.bounds)
        hostView.hostedGraph = graph
        graph.paddingLeft = 0.0
        graph.paddingTop = 0.0
        graph.paddingRight = 0.0
        graph.paddingBottom = 0.0
        
        graph.plotAreaFrame?.paddingLeft = 20.0
        graph.plotAreaFrame?.paddingTop = 20.0
        graph.plotAreaFrame?.paddingRight = 20.0
        graph.plotAreaFrame?.paddingBottom = 20.0
        
        // 2 - Create text style
        let textStyle: CPTMutableTextStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.white()
        textStyle.fontName = "HelveticaNeue-Bold"
        textStyle.fontSize = 16.0
        textStyle.textAlignment = .center
        
        // 3 - Set graph title and text style
        graph.title = "Weight vs Time\n"
        graph.titleTextStyle = textStyle
        graph.titlePlotAreaFrameAnchor = CPTRectAnchor.top
        
        let axisLabelTextStyle = CPTMutableTextStyle()
        axisLabelTextStyle.fontSize = 12
        axisLabelTextStyle.color = CPTColor.white()
        
        let axisSet = CPTXYAxisSet()
        axisSet.xAxis?.majorIntervalLength = 3
        axisSet.xAxis?.minorTickLineStyle = nil
        axisSet.xAxis?.labelingPolicy = .automatic
        axisSet.xAxis?.labelTextStyle = axisLabelTextStyle
        axisSet.xAxis?.visibleRange = CPTPlotRange(location: -2, length: 4)
        axisSet.yAxis?.majorIntervalLength = 3
        axisSet.yAxis?.minorTickLineStyle = nil
        axisSet.yAxis?.labelingPolicy = .automatic
        axisSet.yAxis?.labelTextStyle = axisLabelTextStyle
        axisSet.yAxis?.visibleRange = CPTPlotRange(location: -2, length: 4)
        graph.axisSet = axisSet as CPTAxisSet
        
        // 2 - Create the chart
        let plot = CPTScatterPlot()
        //plot.delegate = graphController
        plot.dataSource = graphController
        //plot.identifier = NSString(string: graph.title!)
        
        // 3 - Configure border style
        let borderStyle = CPTMutableLineStyle()
        borderStyle.lineColor = CPTColor.white()
        borderStyle.lineWidth = 1.0
        graph.borderLineStyle = borderStyle
        
        // 4 - Configure text style
        let labelTextStyle = CPTMutableTextStyle()
        labelTextStyle.color = CPTColor.white()
        labelTextStyle.textAlignment = .center
        plot.labelTextStyle = labelTextStyle
        
        let graphPlotSpace = graph.defaultPlotSpace as! CPTXYPlotSpace
        graphPlotSpace.xRange = CPTPlotRange(location: 0, length: 10)
        graphPlotSpace.yRange = CPTPlotRange(location: -3, length: 6)
        
        //plot.bounds
        
        
        plot.interpolation = .curved
        plot.dataLineStyle = borderStyle
        
        let backgroundColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        plot.backgroundColor = backgroundColor.cgColor
        
        // 5 - Add chart to graph
        graph.add(plot)
        
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

