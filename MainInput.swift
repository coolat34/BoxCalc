//
//  MainInput.swift
//  BoxCalc
//
//  Created by Chris Milne on 20/03/2024.
//

import SwiftUI
import Combine

struct MainInput: View {
    @State private var imagebox = "Box"
    let columns = [GridItem(.fixed(175)),
                   GridItem(.fixed(175))]
        
        
    @EnvironmentObject var size: Sizes
    @State  var length:Int64 = 0
    @State  var width:Int64 = 0
    @State  var height:Int64 = 0
    @State  var inputlength = ""
    @State  var inputwidth = ""
    @State  var inputheight = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
               
                Text("Enter the Length, Width and Height \nof the item that you want to cover\n to the nearest millimetre \n and Press Continue.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .frame(width: 370)

               Form {

                    Section {

                        LazyVGrid(columns: columns, alignment:
                                    HorizontalAlignment.leading, spacing: 1)  {
                         Text("   Length").gridCellColumns(1).font(.system(.body))
                           
                            TextField( "length", text: $inputlength)
                                .keyboardType(.numberPad)
   //                             .frame(width: 6)
                                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .textFieldStyle(.roundedBorder)
                             .font(.system(.body))
                             .onReceive(Just(inputlength)) { newValue in
                                 let filtered = newValue.filter {
                                   "0123456789".contains($0)
                                 }
                               if filtered != newValue {
                                    self.length = Int64(filtered) ?? 0
                               } else {
                                   self.length = Int64(inputlength) ?? 0
                               }
                                 
                             }
                          Text("   Width").gridCellColumns(1).font(.system(.body))
                            TextField("width", text: $inputwidth).textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
  //                              .frame(width: 6)
                                .font(.system(.body))
                                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .onReceive(Just(inputwidth)) { newValue in
                                    let filtered = newValue.filter {
                                      "0123456789".contains($0)
                                    }
                                  if filtered != newValue {
                                        self.width = Int64(filtered) ?? 0
                                  } else {
                                      self.width = Int64(inputwidth) ?? 0
                                  }
                                    
                                }
                          Text("   Height").gridCellColumns(1).font(.system(.body))
                            TextField("height", text: $inputheight).textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
   //                             .frame(width: 6)
                                .font(.system(.body))
                                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .onReceive(Just(inputheight)) { newValue in
                                    let filtered = newValue.filter {
                                      "0123456789".contains($0)
                                    }
                                  if filtered != newValue {
                                       self.height = Int64(filtered) ?? 0
                                  } else {
                                      self.height = Int64(inputheight) ?? 0
                                  }
                                }
                        } /// VStack
                    } /// Section
//77                   Text("Numbers only please").font(.body)
                } /// Form
                ///            Spacer()
                NavigationLink(
                    destination: Rendering(length: self.length, width: self.width, height: self.height)
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

#Preview {
    MainInput()
}
