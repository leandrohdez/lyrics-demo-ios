//
//  ShazamViewModel.swift
//  Lyrics
//
//  Created by Leandro Hernandez on 07/10/21.
//

import ShazamKit
import AVKit
import SwiftUI

class MainViewModel: NSObject, ObservableObject {
    
    @Published var shazamModel = ShazamModel(title: nil, artist: nil, album: nil)
    
    @Published var recording = false
    
    @Published var isDetected: Bool = false
    
    private var audioEngine = AVAudioEngine()
    
    private var session = SHSession()
    
    private var signatureGenerator = SHSignatureGenerator()
    
    override init(){
        super.init()
        session.delegate = self
    }
    
    func startListening(){
        guard !audioEngine.isRunning else {
            audioEngine.stop()
            DispatchQueue.main.async {
                self.recording = true
            }
            return
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.requestRecordPermission { granted in
            guard granted else { return }
            
            try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            let inputNode = self.audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            
            inputNode.removeTap(onBus: .zero)
            
            inputNode.installTap(onBus: .zero, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                self.session.matchStreamingBuffer(buffer, at: nil)
            }
            
            self.audioEngine.prepare()
            do {
                try self.audioEngine.start()
            } catch let error as NSError{
                print("Error al escanear", error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.recording = true
            }
        }
    }
    
    func stopListening() {
        if audioEngine.isRunning {
            audioEngine.stop()
            DispatchQueue.main.async {
                self.recording = false
            }
        }
    }
    
    func reset() {
        self.shazamModel = ShazamModel(title: nil, artist: nil, album: nil)
        self.recording = false
        self.isDetected = false
    }
}

extension MainViewModel: SHSessionDelegate {
    
    //
    func session(_ session: SHSession, didFind match: SHMatch) {
        let mediaItems = match.mediaItems
        if let item = mediaItems.first {
            DispatchQueue.main.async {
                self.shazamModel = ShazamModel(title: item.title, artist: item.artist, album: item.artworkURL)
                if ((self.shazamModel.album?.isFileURL) != nil) {
                    self.isDetected = true
                    self.stopListening()
                }
            }
        }
    }
    
}
