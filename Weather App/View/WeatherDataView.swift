//
//  WeatherDataView.swift
//  Weather App
//
//  Created by Ruangguru on 28/03/22.
//

import SwiftUI

struct WeatherDataView: View {
    var body: some View {
        
        VStack(spacing: 8) {
            
            CustomStackView {
                Label {
                    Text("Air Quality")
                } icon: {
                    Image(systemName: "circle.hexagongrid.fill")
                }
            } contentView: {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("143 - Moderately Polluted")
                        .font(.title3.bold())
                    
                    Text("May cause breathing discomfort for people with lung disease such as asthma and discomfort for people with heart disease, children and older adults.")
                        .fontWeight(.semibold)
                    
                }
                .foregroundStyle(.white)
                
            }
            
            HStack {
                
                CustomStackView {
                    Label {
                        Text("UV Index")
                    } icon: {
                        Image(systemName: "sun.min")
                    }
                } contentView: {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("0")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("Low")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                CustomStackView {
                    Label {
                        Text("Rainfall")
                    } icon: {
                        Image(systemName: "drop.fill")
                    }
                } contentView: {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("0 mm")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("in last 24 hours")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .infinity)
            }
            
            
            CustomStackView {
                Label {
                    Text("10-Day Forecast")
                } icon: {
                    Image(systemName: "calendar")
                }
            } contentView: {
                VStack(alignment: .leading, spacing: 10) {
                    
                    ForEach(forecasts){ forecast in
                        VStack(alignment: .center) {
                            HStack(spacing: 15){
                                Text(forecast.day)
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .frame(width: 60, alignment: .leading)
                                
                                Image(systemName: forecast.image)
                                    .symbolVariant(.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.yellow, .white)
                                    .frame(width: 30)
                                
                                Text("\(Int(forecast.celcius))")
                                    .font(.title3.bold())
                                    .foregroundStyle(.secondary)
                                    .foregroundStyle(.white)
                                
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(.tertiary)
                                        .foregroundStyle(.white)
                                    
                                    GeometryReader { proxy in
                                        
                                        Capsule()
                                            .fill(.linearGradient(Gradient(colors: [.orange, .red]), startPoint: .leading, endPoint: .trailing))
                                            .frame(width: (forecast.celcius / 36) * proxy.size.width)
                                    }
                                }
                                .frame(height: 4)
                            }
                            Divider()
                        }
                        .padding(.top, 8)
                        
                        
                    }
                    
                }
            }
        }
        
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
