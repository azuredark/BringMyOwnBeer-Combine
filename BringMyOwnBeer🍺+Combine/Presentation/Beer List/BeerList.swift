//
//  BeerList.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI
import Combine

struct BeerList: View {
    @ObservedObject var viewModel: BeerListViewModel
    
    init(viewModel: BeerListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.beers) { beer in
                BeerRow(beer: beer)
            }
            .navigationBarTitle(Text("맥주리스트"))
        }
    }
}
