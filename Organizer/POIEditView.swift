//
//  POIEditView.swift
//  Organizer
//
//  Created by Nada Struharova on 6/7/23.
//

import SwiftUI
import CoreLocation

struct POIEditView: View {
    @Environment(\.dismiss) var dismiss
    var poi: PointOfInterest
    var onSave: (PointOfInterest) -> Void
    
    @State private var name: String
    @State private var type: POIType
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Location name", text: $name)
                    Picker("Type of location", selection: $type) {
                        Text("Stage").tag(POIType.Stage)
                        Text("Toilet").tag(POIType.Toilet)
                        Text("Water").tag(POIType.Water)
                        Text("Other").tag(POIType.Other)
                    }
                }
            }
            .navigationTitle("Location details:")
            .toolbar {
                Button("Save") {
                    // modify details of point of interest
                    var newPoi = poi
                    newPoi.id = UUID()
                    newPoi.name = name
                    newPoi.type = type
                    
                    onSave(newPoi)
                    dismiss()
                }
            }
        }
    }
    
    init(poi: PointOfInterest, onSave: @escaping (PointOfInterest) -> Void) {
        self.poi = poi
        self.onSave = onSave
        
        _name = State(initialValue: poi.name)
        _type = State(initialValue: poi.type)
    }
}

struct POIEditView_Previews: PreviewProvider {
    static var previews: some View {
        POIEditView(poi: PointOfInterest.example) {_ in}
    }
}
