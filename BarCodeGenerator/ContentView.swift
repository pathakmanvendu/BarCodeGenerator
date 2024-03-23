//
//  ContentView.swift
//  BarCodeGenerator
//
//  Created by manvendu pathak  on 22/03/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Combine


struct ContentView: View {
    @State private var inputText = ""
    var barcodeGenerator = BarCodeGenerator()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Barcode Generator")
                .font(.system(size: 60,weight: .bold, design: .rounded))
            Text("Please enter your data inside the textfield")
                .font(.headline)
                .padding(.bottom, 20)
            
            TextField("",text: $inputText)
                .padding()
                .font(.title)
                .background(Color(.systemGray6))
            
            Spacer()
            
            VStack(spacing: 0){
                barcodeGenerator.generateBarcode(text: inputText)
                    .resizable()                    .scaledToFit()
                Text(inputText.isEmpty ? "Unknown Data" : inputText)
                
            }
            
        }
        .padding()    }
}

#Preview {
    ContentView()
}


struct BarCodeGenerator {
    let context = CIContext()
    let generator = CIFilter.code128BarcodeGenerator()
    
    func generateBarcode(text: String) -> Image{
        let generator = CIFilter.code128BarcodeGenerator()
        generator.message = Data(text.utf8)
        
        
        if let outputImage = generator.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
            
            let uiImage = UIImage(cgImage: cgImage)
            
            return Image(uiImage: uiImage)
        }
        
        return Image(systemName: "barcode")
        
    }
}
