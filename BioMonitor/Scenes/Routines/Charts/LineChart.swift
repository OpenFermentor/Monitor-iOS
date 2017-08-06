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

    func setup() {
        chartDescription?.enabled = false
        drawGridBackgroundEnabled = true
        dragEnabled = true
        pinchZoomEnabled = false
        self.data = dummyData()
        self.data?.notifyDataChanged()
    }

    func dummyData() -> LineChartData {
        let data = [0,1,2,3,4,5,6,7,8,9,10].map { ChartDataEntry(x: $0, y: $0) }
        let dataSet = LineChartDataSet(values: data, label: "Temperature")
        dataSet.setColor(Material.Color.amber.base)
        dataSet.setCircleColor(Material.Color.amber.accent1)
        let lineData = LineChartData(dataSet: dataSet)
        return lineData
    }

}
