//
//  String+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.06.2024.
//

extension String {
    
    func containsOnlyCyrillicChars() -> Bool {
        range(of: "^[А-Яа-яЁё\\s]+$", options: .regularExpression) != nil
    }
    
    func formatToShortPosition() -> String {
        guard let position = Constants.Text.Positions(rawValue: self) else {
            return ""
        }
        return position.abbreviate()
    }
    
    func formatToPhoneNumber() -> String {
        var formattedText = "+"
        if count > 0 {
            formattedText.append(self[startIndex])
            if count > 1 {
                let secondIndex = index(startIndex, offsetBy: 1)
                let thirdIndex = index(startIndex, offsetBy: min(4, count))
                formattedText += "(" + self[secondIndex..<thirdIndex]
            }
            if count > 4 {
                let fourthIndex = index(startIndex, offsetBy: 4)
                let fifthIndex = index(startIndex, offsetBy: min(7, count))
                formattedText += ")" + self[fourthIndex..<fifthIndex]
            }
            if count > 7 {
                let sixthIndex = index(startIndex, offsetBy: 7)
                let seventhIndex = index(startIndex, offsetBy: min(9, count))
                formattedText += "-" + self[sixthIndex..<seventhIndex]
            }
            if count > 9 {
                let eighthIndex = index(startIndex, offsetBy: 9)
                let endIndex = index(startIndex,offsetBy: min(11, count))
                formattedText += "-" + self[eighthIndex..<endIndex]
            }
        }
        return formattedText
    }
}
