import SwiftUI
import PhotosUI
import AVKit

struct DetailsView: View {
    @EnvironmentObject var visitedCountriesModel: VisitedCountriesModel
    var country: Country
    var city: City
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var airplaneOffset: CGFloat = -100

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // --- ANIMAÇÃO DO AVIÃO ---
                airplaneAnimation
                
                Text(city.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(city.description)
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)

                // --- SELETOR DE MEDIA (FOTOS E VÍDEOS) ---
                // Mudamos 'matching' para .any(of: [.images, .videos])
                PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .videos])) {
                    renderMedia()
                }
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                // Carregamos como Data. Nota: Vídeos muito grandes podem demorar ou falhar aqui.
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    updateCityImage(with: data)
                }
            }
        }
        .onAppear {
            airplaneOffset = UIScreen.main.bounds.width + 100
        }
    }

    // Função auxiliar para decidir o que desenhar (Foto ou Vídeo)
    @ViewBuilder
    func renderMedia() -> some View {
        // Procuramos os dados no modelo global
        if let currentCity = visitedCountriesModel.visitedCountries
            .first(where: { $0.id == country.id })?
            .cities.first(where: { $0.id == city.id }),
           let mediaData = currentCity.imageData {
            
            if let uiImage = UIImage(data: mediaData) {
                // Se for imagem, mostra Image
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
            } else {
                // Se não for imagem, tentamos mostrar como vídeo
                VideoPreview(data: mediaData)
            }
            
        } else {
            // Placeholder original
            placeholderView
        }
    }

    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.gray.opacity(0.2))
            .frame(height: 200)
            .padding(.horizontal)
            .overlay(
                VStack {
                    Image(systemName: "photo.on.rectangle.angled").font(.system(size: 40))
                    Text("Adicionar Foto ou Vídeo")
                }.foregroundColor(.gray)
            )
    }
    
    private var airplaneAnimation: some View {
        HStack {
            Image(systemName: "airplane")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundColor(.blue)
                .offset(x: airplaneOffset)
                .animation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false), value: airplaneOffset)
            Spacer()
        }.padding(.top)
    }

    func updateCityImage(with data: Data) {
        if let countryIndex = visitedCountriesModel.visitedCountries.firstIndex(where: { $0.id == country.id }),
           let cityIndex = visitedCountriesModel.visitedCountries[countryIndex].cities.firstIndex(where: { $0.id == city.id }) {
            visitedCountriesModel.visitedCountries[countryIndex].cities[cityIndex].imageData = data
        }
    }
}
