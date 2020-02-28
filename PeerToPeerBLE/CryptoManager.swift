
import Foundation
import CryptoSwift

class CryptoManager {
    static let instance = CryptoManager()
    
    let key = "keykeykeykeykeyk"
    let iv = "drowssapdrowssap"
    
    func encrypt(input: String) -> Data? {
        do {
            let aes = try AES(key: self.key, iv: self.iv) // aes128
            let ciphertext = try aes.encrypt(Array(input.utf8))
            return Data(bytes:ciphertext, count:ciphertext.count)
        } catch {
            print(error)
            return nil
        }
    }
    
    func decrypt(input: Data) -> String? {
        do {
            let aes = try AES(key: self.key, iv: self.iv) // aes128
            let decrypted = try aes.decrypt(input.bytes)
            return String(bytes: decrypted, encoding: String.Encoding.utf8)
        } catch {
            print(error)
            return nil
        }
    }
}
