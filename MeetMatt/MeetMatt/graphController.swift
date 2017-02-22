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
    let xScalePadding: Double = 0.12
    let yScalePadding: Double = 0.12
    
    let yAxisSpacing: Double = 0.0
    let xAxisSpacing: Double = 0.0
    
    let xAxisTargetNumLabels: Double = 6.0
    
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
        plotSymbolBorder.lineWidth = 1.8
        
        let plotSymbol = CPTPlotSymbol.ellipse()
        plotSymbol.fill = CPTFill(color: backgroundColor)
        plotSymbol.lineStyle = plotSymbolBorder
        
        return plotSymbol
    }
    
    
    func double(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Double {
        //print("---------")
        
        if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.X){
            //print("x \(idx)")
            return _xData[Int(idx)]
        }else if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.Y){
            //sprint("y \(_yData[Int(idx)])")
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
        
        let xMax = _xData.max()!
        let xMin = _xData.min()!
        let yMax = _yData.max()!
        let yMin = _yData.min()!
        
        //print("setting xMax: \(xMax) xMin: \(xMin) yMax: \(yMax) yMin: \(yMin)")
        setAxis(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax)
    }
    
    func setAxis(xMin: Double, xMax: Double, yMin: Double, yMax: Double){
        
        let graphPlotSpace = graph.defaultPlotSpace as! CPTXYPlotSpace
        
        let xPad = (xMax - xMin)*xScalePadding
        let yPad = (yMax - yMin)*yScalePadding
        
        let xMaxPadded = xMax + xPad
        let xMinPadded = xMin - xPad
        let yMaxPadded = yMax + yPad
        let yMinPadded = yMin - yPad
    
        let xLength = NSNumber(value: xMaxPadded - xMinPadded)
        let yLength = NSNumber(value: yMaxPadded - yMinPadded)
        
        let xAxisSpacing = yLength.doubleValue*self.xAxisSpacing
        let yAxisSpacing = xLength.doubleValue*self.yAxisSpacing
        
        let xAxisLocation = yMinPadded //+ xAxisSpacing
        let yAxisLocation = xMinPadded //+ yAxisSpacing
    
        let xRangeLocation = NSNumber(value: xMinPadded - yAxisSpacing)
        let xRangeLength = NSNumber(value: xMaxPadded - xMinPadded + yAxisSpacing)
        let xRange = CPTPlotRange(location: xRangeLocation, length: xRangeLength)
        
        let xGridLocation = NSNumber(value: xMin)
        let xGridLength = NSNumber(value: xMax - xMin)
        let xGridRange = CPTPlotRange(location: xGridLocation, length: xGridLength)
        
        let yRangeLocation = NSNumber(value: yMinPadded - xAxisSpacing)
        let yRangeLength = NSNumber(value: yMaxPadded - yMinPadded + xAxisSpacing)
        let yRange = CPTPlotRange(location: yRangeLocation, length: yRangeLength)
        
        let yGridLocation = NSNumber(value: yMin)
        let yGridLength = NSNumber(value: yMax - yMin)
        let yGridRange = CPTPlotRange(location: yGridLocation, length: yGridLength)
        
        graphPlotSpace.xRange = CPTPlotRange(location: xRange.location, length: xRange.length)
        graphPlotSpace.yRange = CPTPlotRange(location: yRange.location, length: yRange.length)
        
        
        let axes = graph.axisSet as! CPTXYAxisSet
        
        axes.xAxis?.orthogonalPosition = NSNumber(value: xAxisLocation)
        axes.yAxis?.orthogonalPosition = NSNumber(value: yAxisLocation)
        
        axes.xAxis?.visibleAxisRange = xRange
        axes.xAxis?.visibleRange = xRange
        axes.xAxis?.gridLinesRange = xGridRange
        
        axes.yAxis?.visibleAxisRange = yRange
        axes.yAxis?.visibleRange = yRange
        axes.yAxis?.gridLinesRange = yGridRange
        
        setXLabels(numberOfRecords: _xData.count, xMin: xMin, xMax: xMax)
    }
    
    private func calculateDaysBetweenTwoDates(start: Date, end: Date) -> Int {
        
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: start) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: end) else {
            return 0
        }
        return end - start
    }
    
    func setXLabels(numberOfRecords: Int, xMin: Double, xMax: Double){
        
        let axes = graph.axisSet as! CPTXYAxisSet
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        
        var dayComponent = DateComponents()
        dayComponent.day = 1
        
        let minDate = Date(timeIntervalSince1970: xMin)
        let maxDate = Date(timeIntervalSince1970: xMax)
        
        let minDateRounded = NSCalendar.current.startOfDay(for: minDate)
        var maxDateRounded = NSCalendar.current.startOfDay(for: maxDate)
        maxDateRounded = NSCalendar.current.date(byAdding: dayComponent, to: maxDateRounded)!

        print()
        
        var daysBetweenLabels = Double(calculateDaysBetweenTwoDates(start: minDateRounded, end: maxDateRounded))/xAxisTargetNumLabels
        daysBetweenLabels = (daysBetweenLabels.rounded() == 0) ? 1 : daysBetweenLabels.rounded()
        
        dayComponent.day = Int(daysBetweenLabels)
        
       // print("Min Date \(minDateRounded)")
       // print("Min Date \(maxDateRounded)")
        
        var currentDate = minDateRounded
        var xLabels: [CPTAxisLabel] = []
        var xLabelLocations: [NSNumber] = []
        
        let xLabelTextStyle = CPTMutableTextStyle()
        xLabelTextStyle.fontSize = 12
        xLabelTextStyle.color = CPTColor.white()
        xLabelTextStyle.fontName = "HelveticaNeue-Bold"
        
        while (currentDate <= maxDateRounded){
            
            let xLabelString = dateFormatter.string(from: currentDate)
            let xLocation = NSNumber(value: currentDate.timeIntervalSince1970)
            
            print("label \(xLabelString)")
            //print(xLocation)
            
            let xLabel = CPTAxisLabel(text: xLabelString, textStyle: xLabelTextStyle)
            
            //xLabels.append(xLabel)
            xLabelLocations.append(xLocation)
            
            currentDate = NSCalendar.current.date(byAdding: dayComponent, to: currentDate)!
        }
        
        
        let xAxisLabelFormatter = CPTTimeFormatter(dateFormatter: dateFormatter)
        axes.xAxis?.labelingPolicy = .locationsProvided;
        //axes.xAxis?.axisLabels = Set(xLabels);
        axes.xAxis?.labelFormatter = xAxisLabelFormatter
        axes.xAxis?.majorTickLocations = Set(xLabelLocations);
        axes.xAxis?.updateMajorTickLabels()
        //axes.xAxis?.labelRotation = 90.0
        axes.xAxis?.relabel()
    }
    
    func createGraph(frame: CGRect) -> CPTXYGraph {
        
        // 1 - Get a reference to the graph
        graph = CPTXYGraph(frame: frame)
        graph.paddingLeft = 0.0
        graph.paddingTop = 0.0
        graph.paddingRight = 0.0
        graph.paddingBottom = 0.0
        
        graph.plotAreaFrame?.paddingLeft = 45.0
        graph.plotAreaFrame?.paddingTop = 20.0
        graph.plotAreaFrame?.paddingRight = 20.0
        graph.plotAreaFrame?.paddingBottom = 35.0
        
        graph.cornerRadius = 10.0
        graph.backgroundColor = backgroundColor.cgColor
        
        let plot = CPTScatterPlot()
        plot.dataSource = self
        plot.showLabels = false
        
        let labelTextStyle = CPTMutableTextStyle()
        labelTextStyle.color = CPTColor.white()
        labelTextStyle.textAlignment = .center
        plot.labelTextStyle = labelTextStyle
        
        let dataLineStyle = CPTMutableLineStyle()
        dataLineStyle.lineColor = CPTColor.white()
        dataLineStyle.lineWidth = 1.8
        
        plot.interpolation = .linear
        plot.dataLineStyle = dataLineStyle
        
        //plot.backgroundColor = backgroundColor.cgColor
        plot.cornerRadius = 10.0
        
        
        let borderStyle = CPTMutableLineStyle()
        borderStyle.lineColor = CPTColor.white()
        borderStyle.lineWidth = 0.0
        graph.borderLineStyle = borderStyle
        
        let textStyle: CPTMutableTextStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.white()
        textStyle.fontName = "HelveticaNeue-Bold"
        textStyle.fontSize = 16.0
        textStyle.textAlignment = .center
        graph.title = "Weight vs Time\n"
        graph.titleTextStyle = textStyle
        graph.titlePlotAreaFrameAnchor = CPTRectAnchor.top
        
        let axisLabelTextStyle = CPTMutableTextStyle()
        axisLabelTextStyle.fontSize = 12
        axisLabelTextStyle.color = CPTColor.white()
    
        let majorGridLineStyle = CPTMutableLineStyle()
        majorGridLineStyle.lineColor = CPTColor.white()
        majorGridLineStyle.lineWidth = 1.0
        
        let minorGridLineStyle = CPTMutableLineStyle()
        minorGridLineStyle.lineColor = CPTColor.white()
        minorGridLineStyle.lineWidth = 0.5
        
        let axes = graph.axisSet as! CPTXYAxisSet
    
        axes.xAxis?.preferredNumberOfMajorTicks = 6
        axes.xAxis?.labelingPolicy = .none
        axes.xAxis?.labelTextStyle = axisLabelTextStyle
        axes.xAxis?.tickDirection = .negative
        
        axes.xAxis?.gridLinesRange = CPTPlotRange(location: 0, length: 0)
        axes.yAxis?.gridLinesRange = CPTPlotRange(location: 0, length: 0)
        
        axes.xAxis?.axisLineStyle = majorGridLineStyle
        axes.xAxis?.majorTickLineStyle = majorGridLineStyle
        axes.xAxis?.minorTickLineStyle = minorGridLineStyle
        axes.xAxis?.majorGridLineStyle = majorGridLineStyle
        axes.xAxis?.minorGridLineStyle = minorGridLineStyle

        axes.yAxis?.preferredNumberOfMajorTicks = 6
        axes.yAxis?.labelingPolicy = .automatic
        axes.yAxis?.labelTextStyle = axisLabelTextStyle
        axes.yAxis?.tickDirection = .negative
        
        axes.yAxis?.axisLineStyle = majorGridLineStyle
        axes.yAxis?.majorTickLineStyle = majorGridLineStyle
        axes.yAxis?.minorTickLineStyle = minorGridLineStyle
        axes.yAxis?.majorGridLineStyle = majorGridLineStyle
        axes.yAxis?.minorGridLineStyle = minorGridLineStyle
        
        //axes.borderLineStyle = axisLineStyle
        
        //axes.yAxis?.axisConstraints = CPTConstraints(lowerOffset: 1.0)
        
        
        setAxis(xMin: 0, xMax: 0, yMin: 0, yMax: 0)
        
        
        graph.add(plot)
        
        return graph
    }
}

/*
 // Line styles
 let axisLineStyle = CPTMutableLineStyle()
 axisLineStyle.lineWidth = 3.0
 //axisLineStyle.lineCap   = .kCGLineCapRound
 
 let majorGridLineStyle = CPTMutableLineStyle();
 majorGridLineStyle.lineWidth = 0.75;
 majorGridLineStyle.lineColor = CPTColor(genericGray: 0.9)
 
 let minorGridLineStyle = CPTMutableLineStyle()
 minorGridLineStyle.lineWidth = 0.25
 minorGridLineStyle.lineColor = CPTColor(genericGray: 0.95)
 
 // Text styles
 let axisTitleTextStyle = CPTMutableTextStyle()
 axisTitleTextStyle.fontName = "Helvetica-Bold"
 axisTitleTextStyle.fontSize = 14.0
 
 
 let axisSet = graph.axisSet as! CPTXYAxisSet
 let x       = axisSet.xAxis! as CPTXYAxis
 x.labelingPolicy              = .automatic
 x.labelOffset                 = 5
 x.minorTicksPerInterval       = 4
 x.tickDirection               = .none
 x.majorTickLength             = 1.0
 x.majorGridLineStyle          = majorGridLineStyle
 x.minorTickLength             = 1.0;
 x.minorGridLineStyle          = minorGridLineStyle
 x.title                       = "X Axis"
 x.titleTextStyle              = axisTitleTextStyle
 //x.delegate                    = self
 //x.labelFormatter = [self getNSNumberFormatterForNumberLike:xMax];
 
 
 let y = axisSet.yAxis! as CPTXYAxis
 y.labelingPolicy        = .automatic
 y.minorTicksPerInterval = 9
 y.tickDirection         = .negative
 y.majorTickLength       = 1.0
 y.majorGridLineStyle    = majorGridLineStyle
 y.minorTickLength       = 1.0
 y.minorGridLineStyle    = minorGridLineStyle
 y.title                 = "Y Axis"
 y.titleTextStyle        = axisTitleTextStyle
 //y.delegate              = self
 //y.labelFormatter = [self getNSNumberFormatterForNumberLike:yMax];
 //y.titleOffset = 20;
 
 let axes = graph.axisSet as! CPTXYAxisSet
 
 //axes.xAxis?.majorIntervalLength = 3
 /*axes.xAxis?.preferredNumberOfMajorTicks = 4
 axes.xAxis?.minorTickLineStyle = nil
 axes.xAxis?.labelingPolicy = .automatic*/
 print(xMin as NSNumber?)
 axes.xAxis?.orthogonalPosition = xMin as NSNumber?
 
 //axes.yAxis?.majorIntervalLength = 3
 /*axes.yAxis?.preferredNumberOfMajorTicks = 4
 axes.yAxis?.minorTickLineStyle = nil
 axes.yAxis?.labelingPolicy = .automatic*/
 print(yMin as NSNumber?)
 axes.yAxis?.orthogonalPosition = yMin as NSNumber?
 
 
 
 
 //axes.yAxis?.axisConstraints = CPTConstraints(lowerOffset: 1.0)
 //axes.yAxis?.coordinate = .Y
 //axes.yAxis?.orthogonalPosition = 5.0
 
 //yConstraints: [CPConstraints] = {CPConstraints.CPConstraintFixed, CPConstraints.CPConstraintNone}
 //axes.yAxis?.constraints = yConstraints
 
 
 
 //axes.xAxis?.axisConstraints = CPTConstraints(lowerOffset: 1.0)
 //axes.xAxis?.coordinate = .X
 //axes.xAxis?.orthogonalPosition = 0.0
 
 //axes.yAxis?.majorIntervalLength = 3
 
 //plot.identifier = NSString(string: graph.title!)
 //plot.delegate = graphController
 
 */
