//
//  ContentView.swift
//  BoxCalc
//
//  Created by Chris Milne on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var imagebox = "Box"
    let columns = [GridItem(.fixed(175)),
                   GridItem(.fixed(175))]
    @EnvironmentObject var size: Sizes
    @State  var length:Int64 = 0
    @State  var width:Int64 = 0
    @State  var height:Int64 = 0
  
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Calculate amount of Cardboard").font(.title)
                Text("or Stiff Paper required").font(.title)
                Text("to cover the package").font(.title)

                Image("80")
                    .imageScale(.small)
                    .padding()
                Text("Enter the Length, Width and Height").font(.title2)
                Text("of the item that you want to Post").font(.title2)
                Text("to the nearest millimetre").font(.title2)
                Text("and Press Continue.").font(.title2)
                Form {
                    Section {
                        
                        LazyVGrid(columns: columns, alignment:
                                    HorizontalAlignment.leading, spacing: 10 )  {
                            Text("   Length").gridCellColumns(1)
                            TextField("length", value: $length, format: .number).textFieldStyle(.roundedBorder)
                            Text("   Width").gridCellColumns(1)
                            TextField("width", value: $width, format: .number).textFieldStyle(.roundedBorder)
                            Text("   Height").gridCellColumns(1)
                            TextField("height", value: $height, format: .number).textFieldStyle(.roundedBorder)
                        } /// Alignment
                    } /// Section
                    
                } /// Form
                ///            Spacer()
                NavigationLink(
                    destination: OuterInner(length: self.length, width: self.width, height: self.height)
                        .navigationBarBackButtonHidden(true)
                )
                {
                    CustomButton(label: "Continue", width: 300)
                        .padding()
                }  /// CustomButton
            } /// VStack
        } /// NavView
        } /// Body
} /// Struct
