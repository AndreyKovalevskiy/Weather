//
//  WeatherManagerDelegate.swift
//  Weather
//
//  Created by Andrey Kovalevskiy on 7.12.20.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}
