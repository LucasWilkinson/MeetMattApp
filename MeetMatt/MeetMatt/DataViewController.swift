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
    
    var graph: CPTXYGraph! = nil
    let scalePadding: Float = 0.1
    
    var _yData: [Double] = []
    var _xData: [Double] = []
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(_xData.count)
    }
    
    func double(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Double {
        print("---------")
        if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.X){
            print("x \(idx)")
            return _xData[Int(idx)]
        }else if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.Y){
            print("y \(_yData[Int(idx)])")
            return _yData[Int(idx)]
        }else{
            print("??????")
            return 0
        }
    }
    
    func setData(xData: [Double], yData: [Double]){
        if (xData.count != yData.count){
            print("Data size mismatch!")
            return
        }
        
        _yData = yData
        _xData = xData
        
        graph.reloadData()
        scaleAxis()
    }
    
    func scaleAxis(){
        
        if (_xData.count == 0){
            return
        }
        
        var xMax = Float(_xData.max()!)
        var xMin = Float(_xData.min()!)
        var yMax = Float(_yData.max()!)
        var yMin = Float(_yData.min()!)
        
        let xPad = (xMax - xMin)*scalePadding
        let yPad = (yMax - yMin)*scalePadding
        
        xMax += xPad
        xMin -= xPad
        yMax += yPad
        yMin -= yPad
        
        setAxis(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax)
    }
    
    func setAxis(xMin: Float, xMax: Float, yMin: Float, yMax: Float){
        
        let graphPlotSpace = graph.defaultPlotSpace as! CPTXYPlotSpace

        let xLocation = NSNumber(value: xMin)
        let xLength = NSNumber(value: xMax - xMin)
        
        let yLocation = NSNumber(value: yMin)
        let yLength = NSNumber(value: yMax - yMin)
        
        graphPlotSpace.xRange = CPTPlotRange(location: xLocation, length: xLength)
        graphPlotSpace.yRange = CPTPlotRange(location: yLocation, length: yLength)
    }

    func createGraph(frame: CGRect) -> CPTXYGraph {
        
        // 1 - Get a reference to the graph
        graph = CPTXYGraph(frame: frame)
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
        plot.dataSource = self
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
        
        plot.interpolation = .curved
        plot.dataLineStyle = borderStyle
        
        let backgroundColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        plot.backgroundColor = backgroundColor.cgColor
        
        setAxis(xMin: -2, xMax: 2, yMin: -2, yMax: 2)
        
        // 5 - Add chart to graph
        graph.add(plot)
    
        
        
        return graph
    }
    
}



class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var hostView: CPTGraphHostingView!
    
    let fake_yData: [Double] = [1,-1,1.2,-1.2,0,-2,3,-2,1,-1, 1,-1, 1,-1]
    let fake_xData: [Double] = [0, 1,  2,   3,4, 5,6, 7,8,10,11,15,16,17 ]
    
    var dataObject: String = ""
    var graphController: GraphController = GraphController()
    
    let plotSpace = CPTXYPlotSpace()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hostView.hostedGraph = graphController.createGraph(frame: hostView.bounds)
        graphController.setData(xData: fake_xData, yData: fake_yData)
        
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

