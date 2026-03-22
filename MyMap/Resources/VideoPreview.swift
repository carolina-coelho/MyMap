//
//  VideoPreview.swift
//  MyMap
//
//  Created by stud on 12/01/2026.
//
import AVKit
import PhotosUI
import SwiftUI

struct VideoPreview: View {
    let data: Data
    
    var body: some View {
        if let url = createTempURL(from: data) {
            VideoPlayer(player: AVPlayer(url: url))
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal)
        }
    }
    
    func createTempURL(from data: Data) -> URL? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let url = tempDirectory.appendingPathComponent("temp_video.mp4")
        do {
            try data.write(to: url)
            return url
        } catch {
            return nil
        }
    }
}
