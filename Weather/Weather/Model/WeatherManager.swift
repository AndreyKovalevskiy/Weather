//
//  WeatherManager.swift
//  Weather
//
//  Created by Andrey Kovalevskiy on 6.12.20.
//

import Foundation

struct WeatherManager {
    let basicURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=d7f004f449f0de24c9f0e958ea662ea3"
    
    func fetchWeather(city: String) {
        let urlString = basicURL + "&q=\(city)"
        performRequest(url: urlString)
    }
    
    func performRequest(url: String) {
        let url = URL(string: url)
        if let url = url {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let data = data {
                    parseJSON(data: data)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            print("\(weatherData.name) \(weatherData.main.temp)")
        } catch {
            print(error)
        }
    }
}
