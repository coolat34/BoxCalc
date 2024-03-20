//
//  CustomButton.swift
//  CoreDataCar
//
//  Created by Chris Milne on 14/01/2024.
//

import SwiftUI

struct CustomButton: View {
    let label: String
    let width: Int
    let isDisabled: Bool

    init(label: String, width: Int = 300, isDisabled: Bool = false) {
      self.label = label
      self.width = width
      self.isDisabled = isDisabled
    }

    var body: some View {
        Text("\(label)").fontWeight(.heavy)
        .foregroundColor(Color.black)
        .frame(width: CGFloat(width), height: 48, alignment: .center)
        .background(isDisabled ? Color.yellow : Color.teal)
        .cornerRadius(16, antialiased: true)
        .padding()
        .animation(.easeInOut, value: isDisabled)
    }
  }

  struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
      CustomButton(label: "This is the label", isDisabled: true)
    }
  }
