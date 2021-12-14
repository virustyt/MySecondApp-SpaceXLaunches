import Foundation

let not = "\u{0021}" //inverse bit (if A is 0, !A is 1)
let and = "\u{00B7}" //multiplying two bits
let or = "\u{00AC}" // adding two bits (1 + 1 = 1)
let xor = "\u{2295}" //adding by module 2 (1 + 1 = 0)

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
