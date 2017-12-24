//
//  LineChart.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import Charts
import Material

class LineChart: LineChartView {

    func setup(with data: [Result], name: String, color: UIColor, circleColor: UIColor) {
        chartDescription?.enabled = false
        drawGridBackgroundEnabled = true
        dragEnabled = true
        pinchZoomEnabled = false
        self.data = pointsToChartData(points: data, name: name, color: color, circleColor: circleColor)
        self.data?.notifyDataChanged()
    }

    private func pointsToChartData(points: [Result], name: String, color: UIColor, circleColor: UIColor) -> LineChartData {
        let data = points.map { ChartDataEntry(x: $0.x, y: $0.y)}
        let dataSet = LineChartDataSet(values: data, label: name)
        dataSet.mode = .cubicBezier
        dataSet.setColor(color)
        dataSet.setCircleColor(circleColor)
        let lineData = LineChartData(dataSet: dataSet)
        return lineData
    }

}
