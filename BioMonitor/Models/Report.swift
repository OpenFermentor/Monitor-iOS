//
//  Report.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 12/24/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import protocol Decodable.Decodable
import Decodable
import OperaSwift

struct Result: Decodable, OperaDecodable {
    let x: Double
    let y: Double

    static func decode(_ json: Any) throws -> Result {
        return (try? Result(x: json => "x", y: json => "y")) ?? Result(x: 0.0, y: 0.0)
    }
}

struct Report: Decodable, OperaDecodable {

    let specificProductVelocity: [Result]
    let specificPhVelocity: [Result]
    let specificBiomassVelocity: [Result]

    let productVolumetricPerformance: [Result]
    let biomassVolumetricPerformance: [Result]

    let productPerformance: [Result]
    let biomassPerformance: [Result]
    let productBiomassPerformance: [Result]

    let maxProductVolumetricPerformance: Result
    let maxProductVelocity: Result
    let maxPhVelocity: Result
    let maxBiomassVolumetricPerformance: Result
    let maxBiomassVelocity: Result

    static func decode(_ json: Any) throws -> Report {
        return try! Report(
            specificProductVelocity: json => "specific_product_velocity",
            specificPhVelocity: json => "specific_ph_velocity",
            specificBiomassVelocity: json => "specific_biomass_velocity",
            productVolumetricPerformance: json => "product_volumetric_performance",
            biomassVolumetricPerformance: json => "biomass_volumetric_performance",
            productPerformance: json => "product_performance",
            biomassPerformance: json => "biomass_performance",
            productBiomassPerformance: json => "product_biomass_performance",
            maxProductVolumetricPerformance: json => "max_product_volumetric_performance",
            maxProductVelocity: json => "max_product_velocity",
            maxPhVelocity: json => "max_ph_velocity",
            maxBiomassVolumetricPerformance: json => "max_biomass_volumetric_performance",
            maxBiomassVelocity: json => "max_biomass_velocity"
        )
    }
}
