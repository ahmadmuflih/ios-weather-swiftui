//
//  ContentView.swift
//  Weather App
//
//  Created by Ruangguru on 28/03/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        // Since window is decrepted in iOS 15
        // Getting save area using geometry reader
        GeometryReader { proxy in
            
            let topEdge = proxy.safeAreaInsets.top
            
            Home(topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
