//
//  ImageConvert.swift
//  BreachBypass
//
//  Created by Honma Masaru on 2021/06/02.
//

import AppKit
import SwiftUI

final class ImageConvert: ObservableObject {
    static let brank = NSImage(named: NSImage.Name("brank"))!
    private let breachBypassKernel: CIColorKernel

    private var filePath: URL?
    private var ciImage: CIImage?

    @Published private(set) var imageAtOriginal: NSImage?
    @Published private(set) var imageAtBreachBypass: NSImage?

    @Published var thresholdR: Float = 1.0 { didSet { convert() } }
    @Published var thresholdG: Float = 1.0 { didSet { convert() } }
    @Published var thresholdB: Float = 1.0 { didSet { convert() } }

    init() {
        do {
            let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
            let data = try Data(contentsOf: url)
            breachBypassKernel = try CIColorKernel(functionName: "breachBypass", fromMetalLibraryData: data)
        } catch {
            fatalError("Initialization failed")
        }
    }

    func convert() {
        guard ciImage != nil else { return }
        let arguments: [Any] = [ciImage!, thresholdR, thresholdG, thresholdB]
        if let convert = breachBypassKernel.apply(extent: ciImage!.extent, arguments: arguments) {
            imageAtBreachBypass = getNSImage(from: convert)
        } else {
            imageAtBreachBypass = nil
        }
    }

    func openPanel() {
        let panel = NSOpenPanel()
        panel.directoryURL = URL(fileURLWithPath: "\(NSHomeDirectory())/Desktop)")
        panel.allowedFileTypes = ["jpg", "png"]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        if case .OK = panel.runModal() {
            guard let url = panel.url, let img = CIImage(contentsOf: url) else { return }
            filePath = url
            ciImage = img
            imageAtOriginal = getNSImage(from: img)
            convert()
        }
    }

    func save() {
        guard let fileName = filePath?.deletingPathExtension().lastPathComponent else { return }
        savePanel(image: imageAtBreachBypass, fileName: fileName + "_breachBypass")
    }

    func savePanel(image: NSImage?, fileName: String) {
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["jpg", "png"]
        panel.nameFieldStringValue = fileName

        if case .OK = panel.runModal() {
            guard let path = panel.url,
                  let imageData = image?.tiffRepresentation,
                  let imageRep1 = NSBitmapImageRep(data: imageData),
                  let imageRep2 = imageRep1.representation(using: .png, properties: [.compressionFactor: 1.0])
            else { return }
            try? imageRep2.write(to: path)
        }
    }

    private func getNSImage(from ciImage: CIImage) -> NSImage {
        let rep = NSCIImageRep(ciImage: ciImage)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
}
