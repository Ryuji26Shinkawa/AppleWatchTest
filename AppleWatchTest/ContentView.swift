//
//  ContentView.swift
//  AppleWatchTest
//
//  Created by 新川竜司 on 2024/06/01.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel =  PhoneContentViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.countup()
            }) {
                Image(systemName: "arrowtriangle.up.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80.0, height: 80.0)
                    .foregroundColor(.pink)
            }
            .buttonStyle(.plain)
            Text(String(Int(viewModel.counter)))
                .font(.system(size: 64.0))
                .bold()
            Button(action: {
                viewModel.countdown()
            }) {
                Image(systemName: "arrowtriangle.down.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80.0, height: 80.0)
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
