//
//  RoutineReport.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 12/24/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import Charts
import UIKit
import Material
import RxSwift

class RoutineReport: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    public var routineId: Int!

    private var report: Report?
    private let disposeBag = DisposeBag()

    private let chartHeight = CGFloat(300)
    private let spacing = CGFloat(20)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadReport(with: routineId)
    }

    public func loadReport(with routineId: Int) {
        RoutineController.shared.report(routineId: routineId)
            .observeOn(MainScheduler.instance)
            .do(
                onNext: { [unowned self] report in
                    self.messageLabel.isHidden = true
                    self.scrollView.isHidden = false
                    self.report = report
                    self.loadCharts()
                },
                onError: { error in
                    self.messageLabel.text = "Hubo un error al conectarse al servidor."
                    self.messageLabel.isHidden = false
                    self.scrollView.isHidden = true
                }
            )
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func loadCharts() {
        guard let report = report else {
            self.messageLabel.text = "No hay reporte para este experimento."
            self.messageLabel.isHidden = false
            self.scrollView.isHidden = true
            return
        }
        var lastY = CGFloat(spacing)
        let specificProductVelocity = generateChart(data: report.specificProductVelocity, lastY: lastY, name: """
Velocidad Específica de producto
""", color: Material.Color.teal.base, circleColor: Material.Color.teal.accent1)
        lastY = lastY + chartHeight + spacing
        let specificPhVelocity = generateChart(data: report.specificPhVelocity, lastY: lastY, name: """
Velocidad Específica de pH
""", color: Material.Color.blue.base, circleColor: Material.Color.blue.accent1)
        lastY = lastY + chartHeight + spacing
        let specificBiomassVelocity = generateChart(data: report.specificBiomassVelocity, lastY: lastY, name: """
Velocidad Específica de Biomasa
""", color: Material.Color.green.base, circleColor: Material.Color.green.accent1)
        lastY = lastY + chartHeight + spacing
        let productVolumetricPerformance = generateChart(data: report.productVolumetricPerformance, lastY: lastY, name: """
Rendimiento volumétrico de Producto
""", color: Material.Color.pink.base, circleColor: Material.Color.pink.accent1)
        lastY = lastY + chartHeight + spacing
        let biomassVolumetricPerformance = generateChart(data: report.biomassVolumetricPerformance, lastY: lastY, name: """
Rendimiento volumétrico de Biomasa
""", color: Material.Color.lime.base, circleColor: Material.Color.lime.accent1)
        lastY = lastY + chartHeight + spacing
        let productPerformance = generateChart(data: report.productPerformance, lastY: lastY, name: """
Rendimiento de Producto
""", color: Material.Color.orange.base, circleColor: Material.Color.orange.accent1)
        lastY = lastY + chartHeight + spacing
        let productBiomassPerformance = generateChart(data: report.productBiomassPerformance, lastY: lastY, name: """
Rendimiento de producto en función de biomasa
""", color: Material.Color.indigo.base, circleColor: Material.Color.indigo.accent1)
        lastY = lastY + chartHeight + spacing
        let biomassPerformance = generateChart(data: report.biomassPerformance, lastY: lastY, name: """
Rendimiento de Biomasa
""", color: Material.Color.yellow.base, circleColor: Material.Color.yellow.accent1)
        lastY = lastY + chartHeight + spacing
        [specificProductVelocity, specificPhVelocity, specificBiomassVelocity, productVolumetricPerformance, biomassVolumetricPerformance, productPerformance, productBiomassPerformance, biomassPerformance].forEach { self.scrollView.addSubview($0) }
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: lastY)
    }

    private func generateChart(data: [Result], lastY: CGFloat,name: String, color: UIColor, circleColor: UIColor) -> LineChart {
        let frame = CGRect(x: 0, y: lastY, width: view.frame.width, height: chartHeight)
        let chart = LineChart(frame: frame)
        chart.setup(with: data, name: name, color: color, circleColor: circleColor)
        return chart
    }

}
