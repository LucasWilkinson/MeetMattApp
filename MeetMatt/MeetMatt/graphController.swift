//
//  graphController.swift
//  MeetMatt
//
//  Created by Lucas Wiklinson on 2017-02-20.
//  Copyright © 2017 Lucas Wiklinson. All rights reserved.
//

import Foundation
import CorePlot
import Alamofire

class GraphController: NSObject, CPTPlotDelegate, CPTScatterPlotDataSource {
    
    var graph: CPTXYGraph! = nil
    let scalePadding: Float = 0.1
    
    var _yData: [Double] = []
    var _xData: [Double] = []
    
    let backgroundColor = CPTColor(componentRed: 74/255, green: 130/255, blue: 219/255, alpha: 1.0)
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(_xData.count)
    }
    
    func symbol(for plot: CPTScatterPlot, record idx: UInt) -> CPTPlotSymbol? {
        //print("getting plot symbol")
        
        let plotSymbolBorder = CPTMutableLineStyle()
        plotSymbolBorder.lineColor = .white()
        plotSymbolBorder.lineWidth = 1.0
        
        let plotSymbol = CPTPlotSymbol.ellipse()
        plotSymbol.fill = CPTFill(color: backgroundColor)
        plotSymbol.lineStyle = plotSymbolBorder
        
        return plotSymbol
    }
    
    
    func double(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Double {
        //print("---------")
        
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
        
        scaleAxis()
        graph.reloadData()
        
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
        
        
        //print("setting xMax: \(xMax) xMin: \(xMin) yMax: \(yMax) yMin: \(yMin)")
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
        
        graph.plotAreaFrame?.paddingLeft = 0.0
        graph.plotAreaFrame?.paddingTop = 0.0
        graph.plotAreaFrame?.paddingRight = 0.0
        graph.plotAreaFrame?.paddingBottom = 0.0
        
        graph.cornerRadius = 10.0
        
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
        
        // hide the axes
        let lineStyle = CPTMutableLineStyle()
        lineStyle.lineWidth = 0
        
        let axes = graph.axisSet as! CPTXYAxisSet
        //axes.xAxis?.majorIntervalLength = 3
        axes.xAxis?.preferredNumberOfMajorTicks = 4
        axes.xAxis?.minorTickLineStyle = nil
        axes.xAxis?.labelingPolicy = .automatic
        axes.xAxis?.labelTextStyle = axisLabelTextStyle
        axes.xAxis?.axisConstraints = CPTConstraints(lowerOffset: 10.0)
        //axes.xAxis?
        
        //axes.yAxis?.majorIntervalLength = 3
        axes.yAxis?.preferredNumberOfMajorTicks = 4
        axes.yAxis?.minorTickLineStyle = nil
        axes.yAxis?.labelingPolicy = .automatic
        axes.yAxis?.labelTextStyle = axisLabelTextStyle
        axes.yAxis?.axisConstraints = CPTConstraints(lowerOffset: 10.0)
        
        
        //yConstraints: [CPConstraints] = {CPConstraints.CPConstraintFixed, CPConstraints.CPConstraintNone}
        //axes.yAxis?.constraints = yConstraints
        
        // 2 - Create the chart
        let plot = CPTScatterPlot()
        plot.dataSource = self
        plot.showLabels = false
        //plot.identifier = NSString(string: graph.title!)
        //plot.delegate = graphController
        
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
        
        plot.interpolation = .linear
        plot.dataLineStyle = borderStyle
        plot.backgroundColor = backgroundColor.cgColor
        plot.cornerRadius = 10.0
        
        setAxis(xMin: -2, xMax: 2, yMin: -2, yMax: 2)
        
        // 5 - Add chart to graph
        graph.add(plot)
        
        return graph
    }
}
