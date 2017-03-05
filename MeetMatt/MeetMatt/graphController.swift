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

struct scatterPlotPoint {
    var x: Double
    var y: Double
}

enum filterTypesEnum {
    case WEEK
    case MONTH
    case ALL
}

let dataController = DataController()

class DataController: NSObject {
    var data: [scatterPlotPoint] = []
    
    let predictionPolyDeg:Int = 1 //only 1 or 2
    
    var associatedGraphControllers: [GraphController] = []
    
    func setData(data: [scatterPlotPoint]){
        self.data = data.sorted(by: {$0.x < $1.x})
        
        for controller in associatedGraphControllers {
            controller.reloadData()
        }
    }
    
    func getMostRecentWeight() -> Double? {
         return data.max(by: {$0.x < $1.x})?.y
    }
    
    func getLatestDataPoints(numPoints: Int) -> [scatterPlotPoint]{
        var startIndex = Int(data.count-numPoints)
        startIndex = startIndex > 0 ? startIndex : 0
        let endIndex = Int(data.count)
        return Array(data[startIndex..<endIndex])
    }
    
    func predict(xVals: [NSNumber], yVals: [NSNumber], polyDeg: Int, forYval: Double) -> Double{
        let xValsArray = NSMutableArray(array: xVals)
        let yValsArray = NSMutableArray(array: yVals)
        let regression = PolynomialRegression.regression(withXValues: xValsArray, andYValues: yValsArray, polynomialDegree: Int32(polyDeg))
    
        if regression == nil {
            return 0
        }
        
        var prediction: Double = 0
        
        let regressionArray = regression! as NSArray as! [NSNumber]
        
        if (polyDeg == 2){
            let a = regressionArray[2].doubleValue
            let b = regressionArray[1].doubleValue
            let c = regressionArray[0].doubleValue
        
            let y = forYval
        
            let d = pow(b,2)-4*a*(c-y)
            if (d < 0){
                return 0
            }
        
            let x1 = (-b + sqrt(d))/(2*a)
            let x2 = (-b - sqrt(d))/(2*a)
        
            print(x1)
            print(x2)
        
            prediction = x1
        }else if (polyDeg == 1){
            let m = regressionArray[1].doubleValue
            let b = regressionArray[0].doubleValue
            
            let y = forYval
            
            prediction = (y-b)/m
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let targetDate = Date(timeIntervalSince1970: prediction)
        print(targetDate)
        print(dateFormatter.string(from: targetDate))
        
        print(prediction)
        return prediction
    }
    
    func getDatePrediction(targetWeight: Int)-> Double{
        let dataToUseInRegression = getLatestDataPoints(numPoints: 10)

        let xVals = dataToUseInRegression.map({return NSNumber(value: $0.x)})
        let yVals = dataToUseInRegression.map({return NSNumber(value: $0.y)})
        
        print(xVals)
        
        return predict(xVals: xVals, yVals: yVals, polyDeg: predictionPolyDeg, forYval: Double(targetWeight))
    }
    
    func getFilterData(filter: filterTypesEnum) -> [scatterPlotPoint]{
        var filteredData: [scatterPlotPoint] = []
        
        var currentDate = Date()
        currentDate = NSCalendar.current.startOfDay(for: currentDate)
        
        var dayComponent = DateComponents()
        
        switch (filter){
        case .WEEK:
            dayComponent.weekOfYear = -1
            let compareDate = NSCalendar.current.date(byAdding: dayComponent, to: currentDate)
            
            filteredData = data.filter({Date(timeIntervalSince1970: $0.x) > compareDate!})
            break
            
        case .MONTH:
            dayComponent.month = -1
            let compareDate = NSCalendar.current.date(byAdding: dayComponent, to: currentDate)
            
            filteredData = data.filter({Date(timeIntervalSince1970: $0.x) > compareDate!})
            break
            
        case .ALL:
            filteredData = data
            break
        }
        
        return filteredData
    }
}

class GraphController: NSObject, CPTPlotDelegate, CPTScatterPlotDataSource {
    
    var graph: CPTXYGraph! = nil
    let xScalePadding: Double = 0.12
    let yScalePadding: Double = 0.12
    
    let yAxisSpacing: Double = 0.0
    let xAxisSpacing: Double = 0.0
    
    let xAxisTargetNumLabels: Double = 6.0
    
    var filteredData: [scatterPlotPoint] = []
    
    var currentFilter: filterTypesEnum = .ALL
    var filteredDateFormatter = DateFormatter()
    
    let backgroundColor = CPTColor(cgColor: MeetMattBlue.cgColor)
    
    override init() {
        super.init()
        filteredDateFormatter.dateFormat = "MM-dd"
    }
    
    func setFilter(filterType: filterTypesEnum){
        
        currentFilter = filterType
        reloadData()
    }
    
    func filterData(){
        filteredData = dataController.getFilterData(filter: currentFilter)
        
        switch (currentFilter){
        case .WEEK:
            filteredDateFormatter.dateFormat = "E"
            break
            
        case .MONTH:
            filteredDateFormatter.dateFormat = "MM-dd"
            break
            
        case .ALL:
            filteredDateFormatter.dateFormat = "MM-dd"
            break
        }
    }
    
    func reloadData(){
        
        filterData()
        scaleAxis()
        graph.reloadData()
    }
    
    func scaleAxis(){
        
        if (filteredData.count == 0){
            return
        }
        
        var xMax = (filteredData.max(by: {$0.x < $1.x})!).x
        var xMin = (filteredData.min(by: {$0.x < $1.x})!).x
        var yMax = (filteredData.max(by: {$0.y < $1.y})!).y
        var yMin = (filteredData.min(by: {$0.y < $1.y})!).y
        
        if (xMax - xMin < 2*86400) {
            xMax += 86400 // Day in seconds
            xMin -= 86400 // Day in seconds
        }
        
        if (yMax - yMin == 0) {
            yMax += 2
            yMin -= 2
        }
        
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
        
        let xAxisLocation = yMinPadded
        let yAxisLocation = xMinPadded
    
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
        
        setXLabels(numberOfRecords: filteredData.count, xMin: xMin, xMax: xMax)
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
        
        var dayComponent = DateComponents()
        dayComponent.day = 1
        
        let minDate = Date(timeIntervalSince1970: xMin)
        let maxDate = Date(timeIntervalSince1970: xMax)
        
        let minDateRounded = NSCalendar.current.startOfDay(for: minDate)
        var maxDateRounded = NSCalendar.current.startOfDay(for: maxDate)
        maxDateRounded = NSCalendar.current.date(byAdding: dayComponent, to: maxDateRounded)!
        
        var daysBetweenLabels = Double(calculateDaysBetweenTwoDates(start: minDateRounded, end: maxDateRounded))/xAxisTargetNumLabels
        daysBetweenLabels = (daysBetweenLabels.rounded() == 0) ? 1 : daysBetweenLabels.rounded()
        
        dayComponent.day = Int(daysBetweenLabels)

        var currentDate = minDateRounded
        var xLabelLocations: [NSNumber] = []
        
        let xLabelTextStyle = CPTMutableTextStyle()
        xLabelTextStyle.fontSize = 12
        xLabelTextStyle.color = CPTColor.white()
        xLabelTextStyle.fontName = "HelveticaNeue-Bold"
        
        while (currentDate <= maxDateRounded){
            
            //let xLabelString = filteredDateFormatter.string(from: currentDate)
            let xLocation = NSNumber(value: currentDate.timeIntervalSince1970)
            
            //print("label \(xLabelString)")
            xLabelLocations.append(xLocation)
            
            currentDate = NSCalendar.current.date(byAdding: dayComponent, to: currentDate)!
        }
        
        
        let xAxisLabelFormatter = CPTTimeFormatter(dateFormatter: filteredDateFormatter)
        xAxisLabelFormatter.referenceDate = Date(timeIntervalSince1970: 0)
        
        axes.xAxis?.labelingPolicy = .locationsProvided;
        axes.xAxis?.labelFormatter = xAxisLabelFormatter
        axes.xAxis?.majorTickLocations = Set(xLabelLocations);
        
        axes.xAxis?.updateMajorTickLabels()
        axes.xAxis?.relabel()
    }
    
    
    /* --- Start DataSource delegate functions */
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(filteredData.count)
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
        
        if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.X){
            return filteredData[Int(idx)].x
        }else if (CPTScatterPlotField( rawValue: Int(fieldEnum)) == CPTScatterPlotField.Y){
            return filteredData[Int(idx)].y
        }else{
            print("??????")
            return 0
        }
    }
    
    /* ----- End DataSource delegate functions */
    
    
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
