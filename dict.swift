import Foundation

enum HeaderFields: String {
    case Age
    case Connection
    case Date
    case XCache = "X-Cache"
    case XRateLimitRemaining = "X-RateLimit-Remaining"

    static let allFields = [Age, Connection, Date, XCache, XRateLimitRemaining]
}


let header = [
    "Content-Type": "application/json",
    "Age": "0",
    "Via": "1.1 vegur, http/1.1 api-umbrella (ApacheTrafficServer [cMsSf ])",
    "Server": "openresty",
    "Content-Encoding": "gzip",
    "Date": "Fri, 10 Jun 2016 23:17:59 GMT",
    "Content-Length": "735",
    "X-RateLimit-Limit": "1000",
    "X-RateLimit-Remaining": "968",
    "Connection": "Keep-alive",
    "Vary": "Accept-Encoding, Accept-Encoding",
    "X-Cache": "MISS"]


let myHeaders = header.keys.filter ({ (key) -> Bool in
    for field in HeaderFields.allFields {
        if field.rawValue == key {
            return true
        }
    }
    return false
})


let result = header.map { (key, value) in "\(key): \(value)" }
print(result.joinWithSeparator("\n"))
