//
//  ContentView.swift
//  MLFormatHelper
//
//  Created by Choong Han Soong on 23/2/21.
//

import SwiftUI

struct ContentView: View {
    private var typeJson = ["Vott", "Coco"]
    @State private var selectedTypeJson = 0
    @State var filePath = "File Name"
    let toJson = ToJson()
    var body: some View {
        VStack {
            HStack {
                Text(filePath).scaledToFit()
                Button(
                    action: {
                        filePath = openPanel()
                    }, label: {
                        Text("Open File")
                    }
                )
            }
            Picker(selection: $selectedTypeJson, label: Text("")) {
                    ForEach(0 ..< typeJson.count) {
                        Text(self.typeJson[$0])
                    }
                }.padding()
                     .frame(width: 200, height: 70, alignment: .center)
            Button(
                action: {
                    switch selectedTypeJson {
                        case 0: toJson.vottJsonToCreateMLJson(filePath)
                        default: toJson.cocoJsonToCreateMLJson(filePath)
                    }
                } ,
                label: {
                    Text("Convert")
                }
            )
        }
        .frame(minWidth:400)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
