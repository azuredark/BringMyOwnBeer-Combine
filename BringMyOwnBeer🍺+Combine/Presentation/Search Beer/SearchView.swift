//
//  SearchView.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                SearchBar(text: $viewModel.id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                content()
                Spacer()
            }
            .navigationBarTitle("ID 검색")
            .padding()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to:nil, from:nil, for:nil
            )
        }
    }
}

private extension SearchView {
    func content() -> some View {
        if let beer = viewModel.beer {
            return AnyView(details(for: beer))
        } else {
            return AnyView(loading)
        }
    }
    
    func details(for beer: Beer) -> some View {
        BeerResultView(beer: beer)
    }
    
    var loading: some View {
        var loadingMessage: String {
            let containID = viewModel.id != ""
            return containID
                ? "\(viewModel.id)번 맥주를 불러오는 중..."
                : "맥주 ID를 입력하세요."
        }
        return Text(loadingMessage)
            .foregroundColor(.gray)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyService = PunkNetworkDummy()
        let searchViewModel = SearchViewModel(punkService: dummyService)
        
        return ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
            SearchView(viewModel: searchViewModel)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
