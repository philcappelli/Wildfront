//
//  NationalParksState.swift
//  Wildfront
//
//  Created by Philip on 10/9/23.
//

import Foundation

struct NationalParksState {
    var error: NationalParksError?
    var parks: [NationalPark] = []
    var isLoading = false
}
