import Foundation

extension Data {
    /// Converts the data to a pretty-printed JSON string.
    func prettyPrintedJSONString() -> String? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(data: prettyPrintedData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
