//
//  ContentView.swift
//  BreachBypass
//
//  Created by Honma Masaru on 2021/06/02.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var imageConvert: ImageConvert

    var body: some View {
        VStack {
            HStack {
                Button(action: imageConvert.openPanel) { Text("Open") }
                Button(action: imageConvert.save) { Text("Save") }
            }
            .padding()
            HStack {
                Text("Original")
                    .frame(maxWidth: .infinity)
                Text("BreachBypass")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            HStack {
                Image(nsImage: imageConvert.imageAtOriginal ?? ImageConvert.brank)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 300)
                Image(nsImage: imageConvert.imageAtBreachBypass ?? ImageConvert.brank)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 300)
            }
            .padding()
            HStack {
                Text("threshold R")
                Slider(value: $imageConvert.thresholdR, in: 0.0...1.0)
                Text("現在の値: \(String(format: "%.2f", imageConvert.thresholdR))")
            }
            .padding()
            HStack {
                Text("threshold G")
                Slider(value: $imageConvert.thresholdG, in: 0.0...1.0)
                Text("現在の値: \(String(format: "%.2f", imageConvert.thresholdG))")
            }
            .padding()
            HStack {
                Text("threshold B")
                Slider(value: $imageConvert.thresholdB, in: 0.0...1.0)
                Text("現在の値: \(String(format: "%.2f", imageConvert.thresholdB))")
            }
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ImageConvert())
    }
}
