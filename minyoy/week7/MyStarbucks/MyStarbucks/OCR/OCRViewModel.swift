//
//  OCRViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/6/25.
//

import SwiftUI
import Vision
import SwiftData

@Observable
class OCRViewModel: ImageHandling {
    var context: ModelContext?
    
    var images: [UIImage] = []

    func addImage(_ image: UIImage) {
        images.append(image)
        performOCR(on: image)
    }

    func removeImage(at index: Int) {
        guard images.indices.contains(index) else { return }
        images.remove(at: index)
    }

    func getImages() -> [UIImage] {
        images
    }

    private func performOCR(on uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else { return }

        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else { return }

            let recognizedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
            let fullText = recognizedStrings.joined(separator: "\n")
            let parsed = self.parseWithoutRegex(from: fullText)
            
            if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                let receiptImage = ReceiptsImageModel(photo: imageData)
                
                parsed.image = receiptImage
                receiptImage.receipt = parsed

                DispatchQueue.main.async {
                    self.context?.insert(parsed)
                    try? self.context?.save()
                }
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["ko-KR", "en-US"]

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
    
    private func parseWithoutRegex(from text: String) -> ReceiptsModel {
        let lines = text.components(separatedBy: .newlines)

        var store = "장소 없음"
        var totalAmount = 0
        
        var i = 0

        print("===== OCR 디버그 시작 =====")

        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("🔹 [\(i)] \(trimmed)")

            // 장소
            if store == "장소 없음", trimmed.contains("점") {
                store = trimmed
            }

            // 결제 금액
            if trimmed.contains("결제금액"), i + 2 < lines.count {
                let priceLine = lines[i + 2].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }
            
            i += 1
        }

        print("===== OCR 디버그 끝 =====")
        print("🏪 매장명: \(store)")
        print("💰 결제 금액: \(totalAmount)")

        return ReceiptsModel(
            store: store,
            totalAmount: totalAmount
        )
    }
}
