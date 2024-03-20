//
//  Rendering.swift
//  BoxCalc
//
//  Created by Chris Milne on 15/03/2024.
//
/*
 The Function GeneratePDF operates like this:
 (1)    Decide which views you want to render.
 (2)    Create a URL where SwiftUI can write the image data.
 (3)    Call render() on the image renderer to start your rendering     code.
 (4)    Tell SwiftUI how big you want the PDF to be. This might be      a fixed size like A4 or US Letter, or might be the size of      the view hierarchy you’re rendering.
 (5)    Create a CGContext object to handle the PDF pages.
 (6)    Starting a new page.
 (7)    Rendering the SwiftUI views onto that page.
 (8)    Ending the page and closing the PDF document.
 */
import SwiftUI
import PDFKit


@MainActor
struct Rendering: View {
    @State private var pdfURL: URL?
    @EnvironmentObject var size: Sizes
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
        let (calcLength, calcFlaps) = areaCalc(length: length, width: width, height: height)
        
       Text("").background(Color.clear)
        Section {
            VStack() {
                Text("Values on the diagram are in millimetres\n Cut a piece of Cardboard or Stiff paper\n \(calcLength)mm by \(dwidth)mm \n and follow the diagram below")
            } /// VStack
            .font(.body)
        } /// Section
        .background(Color.teal)
        .foregroundColor(.white)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .multilineTextAlignment(.center)
        .frame(width: 400)
        

            VStack(spacing: 2) {
                Text("Flap       Cover        Flap")
                    .foregroundStyle(.black)
                    .font(.title3)
                Text("Width     Width      Width")
                    .foregroundStyle(.black)
                    .font(.title3)
                Text("\(calcFlaps)" +  "          \(length)        " + "      \(calcFlaps)")
            .foregroundStyle(.black)
            .font(.title3)
            
            
                ForEach(1..<6) { tag in

                    let sideLength = sideCalc(tag: tag, width: width, height: height)
                    
                    HStack(spacing: 5) {
                        Text("            ");
/// Geometry Reader uses the available width of the screen.
                        GeometryReader { geo in
                            
                            if tag < 5 {
                                Text("CUT")
                                    .foregroundStyle(.black)
                                  .offset(x: -40, y:60)

                            } /// If
                        } /// HStack
                        .background(Color.orange)                      .frame(width: 50, height: 70)
                        .font(.body)
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
                                .offset(x:52, y:25)
                            if tag < 5 {
                                Text("CUT")
                                    .foregroundStyle(.black)
                                    .offset(x: 52, y:60)
                            } /// If
                        } //// geometry Reader
                        .background(Color.orange)
                        .frame(width: 50, height: 70)
                        Text("             ");
                    } /// HStack
                    .font(.body)
                }  /// ForEach
        } /// VStack
            .font(.body)
        Section {
            VStack() {
                Text("Crease the Covering on the Crease lines \n Then cut the Covering by \(calcFlaps) millimetres \n on both sides where it shows CUT.")
                
            } /// VStack
        } /// Section
        .font(.body)
        .background(Color.teal)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .frame(width: 400)
 
      VStack{
/// Generate Text and Images for the PDF output

            
            Button("Generate PDF") {
                pdfURL = generatePDF(length: length, width: width, height: height)

            }
            .padding()
            if let pdfURL = pdfURL {
                PDFKitView(url: pdfURL)
                
                ShareLink("Export PDF", item: pdfURL)
               Spacer()
            }  /// If
       } /// VStack
       .font(.body)
    }  /// Body
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
        } /// else
    } /// func
    
    //Tag is numbered 1 to 5 which is the also the side that is being displayed .
    // If Tag is even the sideLength=width, else if Tag is odd then sideLength=height
    func sideCalc(tag: Int, width: Int64, height: Int64) -> (Int64) {
        if tag % 2 == 0 {
            let     sideLength = width
            return (sideLength)
        } else {
            let     sideLength = height
            return (sideLength)
        } /// else
    }  /// func
    }  /// Struct
    
    
    // PDF Viewer
    struct PDFKitView: UIViewRepresentable {
        
        let url: URL
        
        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()
            pdfView.document = PDFDocument(url: self.url)
            pdfView.autoScales = true
            return pdfView
        } /// func
        
        func updateUIView(_ pdfView: PDFView, context: Context) {
    /// Update pdf if needed
        } /// func
    } /// struct
    
    
/// 1: Generate pdf from given view
@MainActor    func generatePDF(length: Int64, width: Int64, height: Int64) -> URL {
    ///  Select UI View to render as pdf
    let renderer = ImageRenderer(content:Rendering(length: length, width: width, height: height))
    
    /// 2: Save it to our documents directory
    let url = URL.documentsDirectory.appending(path: "BoxCalc.pdf")
    /// 3: Start the rendering process
    renderer.render { size, context in
        
        /// 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
        var pdfDimension = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        /// 5: Create the CGContext for our PDF pages
        guard let pdf = CGContext(url as CFURL, mediaBox: &pdfDimension, nil) else {
            return
        }
        /// 6: Start at Page 1
        pdf.beginPDFPage(nil)
        /// 7: Render the SwiftUI view data onto the page
        context(pdf)
        /// 8: End the page and close the file
        pdf.endPDFPage()
        pdf.closePDF()
    }
    return url
}

 
#Preview {
    Rendering(length: 250, width: 150, height: 15)
}
