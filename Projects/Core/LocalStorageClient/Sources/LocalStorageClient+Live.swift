import Foundation

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif


public extension LocalStorageClient {
    static let liveValue: Self = {
        let defaults = UserDefaults(suiteName: "group.com.earthIsRound")!

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        return Self(
            initSnowmanItems: { items in
                do {
                    let encodedData = try encoder.encode(items)
                    defaults.set(encodedData, forKey: UserDefaultsKey.snowmanItems)
                    return .success(())
                } catch {
                    return .failure(LocalStorageError.writeError)
                }
            },
            updateSnowmanItems: { items in
                do {

                    var existingItems = try decoder.decode(
                        [SnowmanItemInfo].self,
                        from: defaults.data(forKey: UserDefaultsKey.snowmanItems) ?? Data()
                    )
                    existingItems.append(contentsOf: items)

                    let encodedData = try encoder.encode(existingItems)
                    defaults.set(encodedData, forKey: UserDefaultsKey.snowmanItems)

                    return .success(())
                } catch let decodingError as DecodingError {
                    return .failure(LocalStorageError.readError)
                } catch let encodingError as EncodingError {
                    return .failure(LocalStorageError.writeError)
                } catch {
                    return .failure(LocalStorageError.unknownError)
                }
            },
            getSnowmanItem: { date in
                guard
                    let encodedData = defaults.data(forKey: UserDefaultsKey.snowmanItems)
                else {
                    return .failure(LocalStorageError.fileNotFound)
                }

                do {
                    let items = try decoder.decode([SnowmanItemInfo].self, from: encodedData)
                    let filteredItems = items.filter { $0.date == date }
                    if let item = filteredItems.first {
                        return .success(item)
                    } else {
                        return .failure(LocalStorageError.fileNotFound)
                    }
                } catch {
                    return .failure(LocalStorageError.readError)
                }
            }
        )
    }()
}


