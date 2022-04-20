//
//  Home.swift
//  Weather App
//
//  Created by Ruangguru on 28/03/22.
//

import SwiftUI
import SpriteKit

struct Home: View {
    
    var topEdge: CGFloat
    
    @State var offset: CGFloat = 0
    
    @State var showRain = false
    
    var body: some View {
        
        ZStack {
            
            // Geometry Reaedr for getting height and width
            GeometryReader { proxy in
                
                Image("sky")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            // Blur BG
            .overlay(.ultraThinMaterial)
            
            // RainFall View
            
            GeometryReader { _ in
                SpriteView(scene: RainFall(), options: [.allowsTransparency])
            }
            .ignoresSafeArea()
            .opacity(showRain ? 1 : 0)
            
            ScrollView(.vertical, showsIndicators: false) {
            
                VStack {
                    // Weather Data..
                    VStack(alignment: .center, spacing: 5) {
                        
                        Text("San Jose")
                            .font(.system(size: 35))
                            .foregroundColor(.white)
                            .shadow(radius: 5)

                        Text("98°")
                            .font(.system(size: 35))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        
                        Text("Cloudy")
                            .foregroundStyle(.secondary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        
                        Text("H:103°L:105°")
                            .foregroundStyle(.primary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())

                        
                    }
                    .offset(y: -offset)
                    // For bottom drag effect
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())
                    
                    // Custom data view
                    
                    VStack(spacing: 8) {
                        
                        CustomStackView {
                            Label {
                                
                                Text("Hourly Forecast")
                                
                            } icon: {
                                
                                Image(systemName: "clock")
                            }
                        } contentView: {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    
                                    ForecastView(time: "12 PM", celcius: 94, image: "sun.min")
                                    
                                    ForecastView(time: "1 PM", celcius: 95, image: "sun.haze")
                                    
                                    ForecastView(time: "2 PM", celcius: 96, image: "sun.min")
                                    
                                    ForecastView(time: "3 PM", celcius: 97, image: "cloud.sun")
                                    
                                    ForecastView(time: "4 PM", celcius: 98, image: "sun.haze")
                                    
                                }
                            }
                            
                        }
                        
                        WeatherDataView()
                        
                    }
                    .background {
                        GeometryReader { _ in
                            SpriteView(scene: RainFallLanding(), options: [.allowsTransparency])
                                .offset(y: -10)
                        }
                        .opacity(showRain ? 1 : 0)
                        .offset(y: -(offset + topEdge) > 90 ? -(offset + (90 + topEdge)) : 0)
                    }
                }
                .padding(.top, 25)
                .padding(.top, topEdge)
                .padding([.horizontal, .bottom])
                .overlay(
                    GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        
                        return Color.clear
                    }
                )
                
                // gettting offset..
                
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation {
                    showRain = true
                }
            }
        }
        
    }
    
    private func getTitleOpacity() -> CGFloat {
        
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        
        return opacity
    }
    
    private func getTitleOffset() -> CGFloat {
        
        // setting one max height for whole title..
        // consider max as 120..
        guard offset < 0 else { return 0 }
            
        let progress = -offset / 120
        
        // since toppadding 25
        let newOffset = (progress <= 1.0 ? progress : 1) * 20
        
        return -newOffset
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ForecastView: View {
    
    var time: String
    var celcius: CGFloat
    var image: String
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            
            Image(systemName: image)
                .font(.title2)
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
            // max frame
                .frame(height: 30)
            
            Text("\(Int(celcius))°")
                .font(.callout.bold())
                .foregroundStyle(.white)
            
        }
        .padding(.horizontal, 10)
    }
}

class RainFall: SKScene {
    
    override func sceneDidLoad() {
        guard let node = SKEmitterNode(fileNamed: "RainFall.sks") else { return }
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        backgroundColor = .clear
        
        
        addChild(node)
        
        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}

// Rain Fall Ladning Scene

class RainFallLanding: SKScene {
    
    override func sceneDidLoad() {
        guard let node = SKEmitterNode(fileNamed: "RainFallLanding.sks") else { return }
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        let height = UIScreen.main.bounds.height
        
        anchorPoint = CGPoint(x: 0.5, y: (height - 5) / height)
        
        backgroundColor = .clear
        
        
        addChild(node)
        
        node.particlePositionRange.dx = UIScreen.main.bounds.width - 30
    }
}
