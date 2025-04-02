//
//  PropertyDetailView.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 31/3/25.
//

import SwiftUI
import MapKit

struct PropertyDetailView: View {
    @ObservedObject var viewModel: PropertyDetailViewModel
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // MARK: - Image carousel view
                    if !viewModel.images.isEmpty {
                        ImageCarouselView(images: viewModel.images)
                    }
                    
                    if let detail = viewModel.detail {
                        // MARK: - Details info
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(alignment: .bottom) {
                                Text(viewModel.getPropertyType(detail.extendedPropertyType))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primaryTextColor)
                                
                                Spacer()
                                
                                Text("\(Int(detail.priceInfo.amount)) \(detail.priceInfo.currencySuffix)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.detailsColor)
                            }
                            
                            if let rooms = detail.moreCharacteristics.roomNumber {
                                Text("🛏️ " + String(localized: "rooms") + ": \(rooms)")
                            }
                            
                            if let baths = detail.moreCharacteristics.bathNumber {
                                Text("🛁 " + String(localized: "baths") + ": \(baths)")
                            }
                            
                            if let size = detail.moreCharacteristics.constructedArea {
                                Text("📐 " + String(localized: "area") + ": \(size) m²")
                            }
                            
                            Text(detail.propertyComment)
                                .font(.body)
                                .foregroundColor(.secondaryTextColor)
                                .padding(.vertical, 10)
                        }
                        .padding(.horizontal)
                        
                        // MARK: - Map view
                        PropertyMapView(coordinate: CLLocationCoordinate2D(
                            latitude: detail.ubication.latitude,
                            longitude: detail.ubication.longitude
                        ))
                    }
                }
                .padding(.vertical)
            }
            .padding(.horizontal, 10)
        }
        .onAppear {
            loadPropertyDetail()
        }
        .onReceive(viewModel.$errorMessage) { message in
            showAlert = message != nil
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(viewModel.errorMessage ?? ""),
                  dismissButton: .default(Text("OK")) {
                dismiss()
                viewModel.errorMessage = nil
            })
        }
    }
    
    private func loadPropertyDetail() {
        Task {
            await viewModel.loadPropertyDetail()
        }
    }
}


struct ImageCarouselView: View {
    let images: [UIImage]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 230)
                    .clipped()
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
        }
        .frame(height: 230)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}


struct PropertyMapView: View {
    let coordinate: CLLocationCoordinate2D

    var body: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02,
                                       longitudeDelta: 0.02)
            )),
            annotationItems: [Location(coordinate: coordinate)]
        ) { place in
            MapMarker(coordinate: place.coordinate, tint: .detailsColor)
        }
        .frame(height: 250)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.borderColor, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
