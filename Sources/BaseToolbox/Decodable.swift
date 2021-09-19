import Foundation

extension Decodable {
  public static func read(from url: URL) -> Self? {
    do {
      return try JSONDecoder().decode(self, from: Data(contentsOf: url))
    } catch {
      print("[SessionManager] error reading session data at ", url, error)
    }
    return nil
  }
}
