//
//  MainView.swift
//  Lyrics
//
//  Created by Leandro Hernandez on 07/10/21.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                if self.viewModel.recording {
                    LottieView(
                        animationName: "75794-abstract",
                        loopMode: .loop,
                        contentMode: .scaleAspectFit
                    )
                    .frame(maxWidth: .infinity)
                }
                
                VStack(alignment: .center, spacing: 16) {
                    
                    ZStack {
//                        HStack(alignment: .center) {
//
//                            AsyncImage(url: self.viewModel.shazamModel.album) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                                    .edgesIgnoringSafeArea(.all)
//                            } placeholder: {
//                                EmptyView()
//                            }
//                            .frame(width: 240, height: 240, alignment: .center)
//                            .cornerRadius(16)
//                            .shadow(color: Color.blue, radius: 18, x: 0, y: 0)
//                        }
//                        .padding()
//
//                        if !self.viewModel.isDetected {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("Identifying\nsong")
                                        .foregroundColor(.white)
                                        .font(.system(size: 40))
                                        .bold()
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal, 24)
                                        .padding(.top, 40)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(self.viewModel.recording ? "Listening..." : "Tap to start")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 16))
                                        .bold()
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal, 24)
                                    Spacer()
                                }
                            }
                    }

                    Spacer()
                    
                    ZStack(alignment: .center){
                        
                        Button(action:{
                            if self.viewModel.recording {
                                self.viewModel.stopListening()
                            } else {
                                self.viewModel.startListening()
                            }
                           
                        }){
                            Image(systemName: self.viewModel.recording ? "mic.slash" : "mic.fill")
                                .font(.system(size: 21))
                        }
                        .buttonStyle(MicButtonStyle())
                        
//                        NavigationLink(destination: LyricsView(artist: viewModel.shazamModel.artist ?? "Sin artista", title: viewModel.shazamModel.title ?? "Sin titulo")){
//                            Text("Ver letra")
//                                .foregroundColor(.white)
//                        }.buttonStyle(.bordered)
//                            .controlSize(.large)
//                            .shadow(radius: 4)
//                            .tint(.orange)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 40)
                }
                .padding(.all)
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
            }
            .sheet(isPresented: self.$viewModel.isDetected.animation()) {
                ResultView(viewModel: ResultViewModel(shazamModel: self.viewModel.shazamModel))
            }
        }
    }
}


