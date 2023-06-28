//
//  ContentView.swift
//  CodingChallenge
//
//  Created by Isaiah Ojo on 28/06/2023.
//

import SwiftUI
import CoreData
import Combine
import Foundation

// Define the Product model
struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

// Define the Products model
struct Products: Decodable {
    let products: [Product]
}

class ProductService {
    var cancellable: AnyCancellable?

    func fetchProducts(url: String) -> AnyPublisher<Products, Error> {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Products.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class ProductViewModel: ObservableObject {
    private var productService: ProductService
    private var cancellables = Set<AnyCancellable>()

    @Published var products = [Product]()

    init(productService: ProductService = ProductService()) {
        self.productService = productService
    }

    func fetchProducts(url: String) {
        productService.fetchProducts(url: url)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] products in
                self?.products = products.products
            }
            .store(in: &cancellables)
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancellable?.cancel()
    }

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct URLImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image

    init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }

    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

struct ProductView: View {
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    HStack {
                        URLImage(url: URL(string: product.thumbnail)!)
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text(product.description)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchProducts(url: "https://dummyjson.com/products")
            }
            .navigationTitle("Products")
        }
    }
}

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        VStack {
            URLImage(url: URL(string: product.thumbnail)!)
                .frame(width: 200, height: 200)
            Text(product.title)
                .font(.largeTitle)
            Text(product.description)
            Spacer()
        }
        .padding()
        .navigationTitle(product.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel())
    }
}
