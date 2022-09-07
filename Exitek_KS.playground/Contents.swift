import UIKit

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum MobileError: String, Error {
    case isExists = "IMEI is Exists!"
    case isNotFined = "IMEI is Not Fined!"
}

class MobilesStorage: MobileStorage {
    var mobiles = Set<Mobile>()
    
    func getAll() -> Set<Mobile> {
        if mobiles.isEmpty {
            print("mobile list is empty")
        } else {
            print(mobiles)
        }
        return mobiles
        
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        let mobiles = mobiles.filter {$0.imei == imei}
        let mobile = mobiles.first
        print(mobile ?? print(MobileError.isNotFined.rawValue))
        
        return mobile
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        let mobile = mobile
        guard mobile.imei != mobiles.first?.imei else {
            print(MobileError.isExists.rawValue)
            throw MobileError.isExists
        }
        mobiles.insert(mobile)
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        let product = product
        let isExists = exists(product)
        guard isExists else {
            print(MobileError.isNotFined.rawValue)
            throw MobileError.isNotFined
        }
        mobiles.remove(product)
    }
    
    func exists(_ product: Mobile) -> Bool {
        if mobiles.contains(product) {
            print("\(product) exists")
            
            return true
        }
        else {
            print("\(product) doesn't exist")
            return false
        }
    }
}

let mobilesStorage = MobilesStorage()

let mobile1 = Mobile(imei: "1", model: "iPhone")
let mobile2 = Mobile(imei: "1", model: "Samsung")
let mobile3 = Mobile(imei: "2", model: "Samsung")
let mobile4 = Mobile(imei: "3", model: "XoMi")
let mobile5 = Mobile(imei: "4", model: "iPhone")

mobilesStorage.getAll()
do {
    try? mobilesStorage.save(mobile1)
}

do {
    try? mobilesStorage.save(mobile2)
}

do {
    try? mobilesStorage.save(mobile3)
}

do {
    try? mobilesStorage.save(mobile4)
}

mobilesStorage.getAll()


mobilesStorage.exists(mobile3)

do {
    try? mobilesStorage.delete(mobile3)
}

mobilesStorage.exists(mobile3)

do {
    try? mobilesStorage.delete(mobile5)
}

mobilesStorage.findByImei("1")

mobilesStorage.findByImei("0")


