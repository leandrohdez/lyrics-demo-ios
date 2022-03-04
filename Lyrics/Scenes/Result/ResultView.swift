//
//  ResultView.swift
//  Lyrics
//
//  Created by Leandro Hernandez on 07/10/21.
//

import SwiftUI
import Combine

struct ResultView: View {
    
    @StateObject private var viewModel: ResultViewModel
    
    @ObservedObject var imageLoader:ImageLoader
        @State var image:UIImage = UIImage()
    
    init(viewModel: ResultViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = ImageLoader(urlString: viewModel.shazamModel.album?.absoluteString ?? "")
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 16) {
                
                Image(uiImage: self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(16)
                    .shadow(color: Color.blue, radius: 18, x: 0, y: 0)
                    .padding(.bottom, 24)
                    .onReceive(imageLoader.didChange) { data in
                        self.image = UIImage(data: data) ?? UIImage()
                }
                
                Text(self.viewModel.shazamModel.artist ?? "")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                
                Text(self.viewModel.shazamModel.title ?? "")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                
                ScrollView(.vertical, showsIndicators: false) {
                    Text(self.viewModel.lyricModel.lyrics ?? "Not found")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .padding(.top, 24)
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
            .onAppear {
                Task {
                    await self.viewModel.fetch(artist: self.viewModel.shazamModel.artist ?? "", title: self.viewModel.shazamModel.title ?? "")
                }
            }
        }
    }
}


class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
