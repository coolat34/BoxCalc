//
//  OuterInner.swift
//  BoxCalc
//
//  Created by Chris Milne on 27/02/2024.
//

import SwiftUI

struct OuterInner: View {
    @EnvironmentObject var size: Sizes
     @Environment(\.dismiss) var dismiss
     @State  var length:Int64
     @State  var width:Int64
     @State  var height:Int64
     @State  var dlength: Int64 = 0
     @State  var flaps: Int64 = 0

    
    init(length: Int64, width: Int64, height: Int64) {
            self._length = State(initialValue: length)
            self._width = State(initialValue: width)
            self._height = State(initialValue: height)
        }
   
     var body: some View {
         let dwidth: Int64 = (width * 2) + (height * 3)
         
/* areaCalc function is called with actual values of length, width, and height, and the returned values are stored in calcLength and calcFlaps, which are then used in the Text view.
 */
             let (calcLength, calcFlaps) = areaCalc(length: length, width: width, height: height)
         Text("")
         Section {
             VStack() {
                 Text("Values on the diagram are in millimetres")
                 Text("Cut a piece of Cardboard or Stiff paper")
                 Text("\(calcLength)mm by \(dwidth)mm")
                 Text("and follow the diagram below\n")
                 
             }

         }
         .font(.title2)
         .background(Color.teal)
         .foregroundColor(.white)
         .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
         
         VStack(spacing: 2) {
             Text("Flap       Cover      Flap")
                 .foregroundStyle(.black)
             Text("Width       Width      Width")
                 .foregroundStyle(.black)
             Text("\(calcFlaps)" +  "         \(length)        " + "      \(calcFlaps)")
                 .foregroundStyle(.black)
             
             
             
             ForEach(1..<6) { tag in
                 
                 let sideLength = sideCalc(tag: tag, width: width, height: height)
                 
                 HStack(spacing: 5) {
                     Text("            ")
                     /// Geometry Reader uses the available width of the screen.
                     GeometryReader { geo in
                         
                         if tag < 5 {
                             Text("CUT")
                                 .foregroundStyle(.black)
                                 .offset(x: -35, y:60)
                         }
                     }
                     .background(Color.orange)
                     .frame(width: 50, height: 70)
                     
                     GeometryReader { geo in
                         
                         if tag < 5 {
                             Text("Crease")
                                 .foregroundStyle(.white)
                                 .offset(x: 20, y:50)
                         } /// If
                     }   /// Geometry Reader
                     .background(Color.orange)
                     .frame(width: 100, height: 70)
                     
                     GeometryReader { geo in
                         
                         Text("\(sideLength)")
                             .background(Color.white)
                             .rotationEffect(.degrees(+90))
                             .offset(x:50, y:25)
                         if tag < 5 {
                             Text("CUT")
                                 .foregroundStyle(.black)
                                 .offset(x: 50, y:60)
                         } /// If
                     } //// geometry Reader
                     .background(Color.orange)
                     .frame(width: 50, height: 70)
                     Text("             ")
                 } /// HStack
             }  /// ForEach
         } /// VStack
         ///
         Section {
             VStack() {
                 Text("Crease the Covering along the Crease lines.")
                 Text("Then cut the Covering by \(calcFlaps) millimetres")
                 Text("where it shows CUT.")
                 Text("Now fold Covering around the package.")
                 
             } /// VStack
         }
              .font(.title3)
             .background(Color.teal)
             .foregroundColor(.white)
             .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
         
         Spacer()
         Button("Go Back") {
             dismiss()
         }   /// Button
         .background(Color.teal)
         .foregroundColor(.white)
         .buttonStyle(.borderedProminent)
         Spacer()
         }/// Body
    ///
    func areaCalc(length: Int64, width: Int64, height: Int64) -> (dlength: Int64, flaps: Int64) {
        if width < height {
            let dlength = length + (width * 2)
            let flaps = width
            return (dlength, flaps)
        } else {
            let dlength = length + (height * 2)
            let flaps = height
            return (dlength, flaps)
        }
    }
    
    //Tag is numbered 1 to 5 which is the also the side that is being displayed .
    // If Tag is even the sideLength=width, else if Tag is odd then sideLength=height
    func sideCalc(tag: Int, width: Int64, height: Int64) -> (Int64) {
            if tag % 2 == 0 {
                let     sideLength = width
                return (sideLength)
            } else {
                let     sideLength = height
            return (sideLength)
            }
    }
    
 } /// Struct





