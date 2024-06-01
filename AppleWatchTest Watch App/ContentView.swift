//
//  ContentView.swift
//  AppleWatchTest Watch App
//
//  Created by 新川竜司 on 2024/06/01.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel =  WatchContentViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.countup()
            }) {
                Image(systemName: "arrowtriangle.up.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60.0, height: 60.0)
                    .foregroundColor(.pink)
            }
            .buttonStyle(.plain)
            Text(String(Int(viewModel.counter)))
                .font(.system(size: 48.0))
                .bold()
            Button(action: {
                viewModel.countdown()
            }) {
                Image(systemName: "arrowtriangle.down.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60.0, height: 60.0)
                    .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
