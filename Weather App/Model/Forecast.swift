//
//  Forecast.swift
//  Weather App
//
//  Created by Ruangguru on 28/03/22.
//

import SwiftUI

struct DayForecast: Identifiable {
    var id = UUID().uuidString
    var day: String
    var celcius: CGFloat
    var image: String
}

var forecasts = [
    DayForecast(day: "Today", celcius: 30, image: "sun.min"),
    DayForecast(day: "Wed", celcius: 29, image: "cloud.sun"),
    DayForecast(day: "Tue", celcius: 28, image: "cloud.sun.bolt"),
    DayForecast(day: "Thu", celcius: 32, image: "sun.max"),
    DayForecast(day: "Fri", celcius: 28, image: "cloud.sun"),
    DayForecast(day: "Sat", celcius: 29, image: "cloud.sun"),
    DayForecast(day: "Sun", celcius: 32, image: "sun.max"),
    DayForecast(day: "Mon", celcius: 31, image: "sun.max"),
    DayForecast(day: "Tue", celcius: 27, image: "cloud.sun.bolt"),
    DayForecast(day: "Wed", celcius: 30, image: "sun.min"),
]
