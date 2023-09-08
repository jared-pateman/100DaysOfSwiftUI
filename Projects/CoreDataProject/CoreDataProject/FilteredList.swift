//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Jared Pateman on 08/09/2023.
//

import SwiftUI

enum FilterType: String, CaseIterable {
    case beginsWith = "BEGINSWITH"
    case beginsWithCaseInsensitive = "BEGINSWITH[c]"
    case contains = "CONTAINS"
    case containsCaseInsenstitive = "CONTAINS[c]"
}

struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter: String, predicate: FilterType, sortDescriptors: [SortDescriptor<Singer>] = []) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "lastName \(predicate.rawValue) %@", filter))
    }
}
