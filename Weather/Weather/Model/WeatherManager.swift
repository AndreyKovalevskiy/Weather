//
//  WeatherManager.swift
//  Weather
//
//  Created by Andrey Kovalevskiy on 6.12.20.
//

import Foundation

struct WeatherManager {
    let basicURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=d7f004f449f0de24c9f0e958ea662ea3"
    var delegate: WeatherManagerDelegate?
    
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
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                if let data = data {
                    if let weatherModel = parseJSON(data: data) {
                        DispatchQueue.main.async {
                            delegate?.didUpdateWeather(self, weatherModel: weatherModel)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            return WeatherModel(cityName: weatherData.name, temperature: weatherData.main.temp, conditionId: weatherData.weather[0].id)
        } catch {
            return nil
        }
    }
}
