import Foundation
import PlaygroundSupport

//MARK: - bit operations
public let not = "\u{0021}" //inverse bit (if A is 0, !A is 1)
public let and = "\u{00B7}" //multiplying two bits
public let or = "\u{00AC}" // adding two bits (1 + 1 = 1)
public let xor = "\u{2295}" //adding by module 2 (1 + 1 = 0)
public let Wt = "Wt"
public let Kt = "Kt"
public let addTwoWords = " + "
public let bitShiftLeft = "<<"
public let substractHex = "-"

public func Ch(E: String, F: String, G: String) -> String {
    var rezult: String
    rezult = "(" + E + and + F + ")" + xor + "(" + not + E + and + G + ")"
    return rezult
}

public func Ma(A: String, B: String, C: String) -> String {
    var result:String
    result = "(" + A + and + B + ")" + xor + "(" + A + and + C + ")" + xor + "(" + B + and + C + ")"
    return result
}

public func bitShift0(A: String) -> String {
    var result: String
    result = "(" + A + ">>" + "2" + ")" + xor + "(" + A + ">>" + "13" + ")" + xor + "(" + A + ">>" + "22" + ")"
    return result
}

public func bitShift1(E: String) -> String {
    var result: String
    result = "(" + E + ">>" + "6" + ")" + xor + "(" + E + ">>" + "11" + ")" + xor + "(" + E + ">>" + "25" + ")"
    return result
}

public func addWords(first: String, second: String) -> String{
    var result: String
    result = first + addTwoWords + second
    return result
}

//MARK: - words operations
public func makeNewA(arrayOfWords: [String]) -> String{
    let result: String
    
    result = "(" + arrayOfWords[7] + addTwoWords + Wt + addTwoWords + Kt + addTwoWords
        + Ch(E: arrayOfWords[4], F: arrayOfWords[5], G: arrayOfWords[6]) + addTwoWords
        + bitShift1(E: arrayOfWords[5]) + addTwoWords
        + Ma(A: arrayOfWords[0], B: arrayOfWords[1], C: arrayOfWords[2]) + addTwoWords
        + bitShift0(A: arrayOfWords[0]) + ")"
    
    return result
}

public func makeNewE(arrayOfWords: [String]) -> String {
    let result: String
    
    result = "(" + arrayOfWords[7] + addTwoWords + Wt + addTwoWords + Kt + addTwoWords
        + Ch(E: arrayOfWords[4], F: arrayOfWords[5], G: arrayOfWords[6]) + addTwoWords
        + bitShift1(E: arrayOfWords[5]) + addTwoWords
    + arrayOfWords[3] + ")"
    
    return result
}

public func makeNewB(arrayOfWords: [String]) -> String {
    return arrayOfWords[0]
}

public func makeNewC(arrayOfWords: [String]) -> String {
    return arrayOfWords[1]
}

public func makeNewD(arrayOfWords: [String]) -> String {
    return arrayOfWords[2]
}

public func makeNewF(arrayOfWords: [String]) -> String {
    return arrayOfWords[4]
}

public func makeNewG(arrayOfWords: [String]) -> String {
    return arrayOfWords[5]
}

public func makeNewH(arrayOfWords: [String]) -> String {
    return arrayOfWords[6]
}

//MARK: - writo to file
public func writeResultTwoDisk(arrayOfWords: [String], UrlPath: URL){
    let filePathForA = URL(fileURLWithPath: "word A.txt", relativeTo: UrlPath).path
    let filePathForB = URL(fileURLWithPath: "word B.txt", relativeTo: UrlPath).path
    let filePathForC = URL(fileURLWithPath: "word C.txt", relativeTo: UrlPath).path
    let filePathForD = URL(fileURLWithPath: "word D.txt", relativeTo: UrlPath).path
    let filePathForE = URL(fileURLWithPath: "word E.txt", relativeTo: UrlPath).path
    let filePathForF = URL(fileURLWithPath: "word F.txt", relativeTo: UrlPath).path
    let filePathForG = URL(fileURLWithPath: "word G.txt", relativeTo: UrlPath).path
    let filePathForH = URL(fileURLWithPath: "word H.txt", relativeTo: UrlPath).path

    let wordA = arrayOfWords[0]
    let wordB = arrayOfWords[1]
    let wordC = arrayOfWords[2]
    let wordD = arrayOfWords[3]
    let wordE = arrayOfWords[4]
    let wordF = arrayOfWords[5]
    let wordG = arrayOfWords[6]
    let wordH = arrayOfWords[7]

    do {
        try wordA.write(toFile: filePathForA, atomically: true, encoding: String.Encoding.utf8)
        try wordB.write(toFile: filePathForB, atomically: true, encoding: String.Encoding.utf8)
        try wordC.write(toFile: filePathForC, atomically: true, encoding: String.Encoding.utf8)
        try wordD.write(toFile: filePathForD, atomically: true, encoding: String.Encoding.utf8)
        try wordE.write(toFile: filePathForE, atomically: true, encoding: String.Encoding.utf8)
        try wordF.write(toFile: filePathForF, atomically: true, encoding: String.Encoding.utf8)
        try wordG.write(toFile: filePathForG, atomically: true, encoding: String.Encoding.utf8)
        try wordH.write(toFile: filePathForH, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        print(error)
    }
}





