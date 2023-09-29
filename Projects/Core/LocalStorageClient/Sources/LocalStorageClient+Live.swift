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
            appendSnowmanItemInfo: { items in
                do {
                    var existingItems: [SnowmanItemInfo] = []

                    if let data = defaults.data(forKey: UserDefaultsKey.snowmanItems) {
                        if let decodedItems = try? decoder.decode([SnowmanItemInfo].self, from: data) {
                            existingItems = decodedItems
                        }
                    }

                    existingItems.append(contentsOf: items)

                    // 날짜를 기준으로 내림차순 정렬
                    existingItems.sort { $0.date > $1.date }

                    let maxCount = 7
                    if existingItems.count > maxCount {
                        existingItems = Array(existingItems.prefix(maxCount))
                    }

                    let encodedData = try encoder.encode(existingItems)
                    defaults.set(encodedData, forKey: UserDefaultsKey.snowmanItems)
                    return .success(())
                } catch {
                    return .failure(LocalStorageError.writeError)
                }
            },
            updateSnowmanItemPoint: { date, updatedItemPoint in
                do {
                    var snowmanItemInfos = try decoder.decode(
                        [SnowmanItemInfo].self,
                        from: defaults.data(forKey: UserDefaultsKey.snowmanItems) ?? Data()
                    )

                    guard let index = snowmanItemInfos.firstIndex(where: { $0.date == date }) else {
                        return .failure(LocalStorageError.fileNotFound)
                    }

                    var itemPoints = snowmanItemInfos[index].itemPoint

                    if let itemIndex = itemPoints.firstIndex(where: { $0.id == updatedItemPoint.id }) {
                        itemPoints[itemIndex] = updatedItemPoint
                    } else {
                        itemPoints.append(updatedItemPoint)
                    }

                    snowmanItemInfos[index].itemPoint = itemPoints

                    let encodedData = try encoder.encode(snowmanItemInfos)
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
                print(date)
                do {
                    let items = try decoder.decode([SnowmanItemInfo].self, from: encodedData)
                    print(items)
                    let filteredItems = items.filter { $0.date == date }
                    dump(filteredItems)
                    if let item = filteredItems.first {
                        return .success(item)
                    }

                    return .failure(LocalStorageError.fileNotFound)
                } catch {
                    return .failure(LocalStorageError.readError)
                }
            },
            deleteAll: {
              defaults.removeObject(forKey: UserDefaultsKey.snowmanItems)
            }
        )
    }()
}


