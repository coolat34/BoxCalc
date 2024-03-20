//
//  ContentView.swift
//  BoxCalc
//
//  Created by Chris Milne on 19/02/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var size: Sizes
    /*
    @State private var imagebox = "Box"
    let columns = [GridItem(.fixed(175)),
                   GridItem(.fixed(175))]
        
        
    
    @State  var length:Int64 = 0
    @State  var width:Int64 = 0
    @State  var height:Int64 = 0
    @State  var inputlength = ""
    @State  var inputwidth = ""
    @State  var inputheight = ""
  */
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Calculate amount of Cardboard \n or Stiff Paper required \n to cover a package")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(width: 400)
                
                Image("80")
                    .imageScale(.small)
                    .padding()
                Text("Enter the Length, Width and Height \nof the item that you want to cover\n to the nearest millimetre. \n The screen will then display a view of the covering. \n You will then have the option to\n Generate a PDF. \n Once the PDF is generated, you can either Export the PDF\n to Whatsapp or Email,\nPrint or Save.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 400)

              
                NavigationLink(
                    destination: MainInput()
                        .navigationBarBackButtonHidden(false)
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
    ContentView()
}
