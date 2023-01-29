@main
public struct Potter {
    public static func main() {
        print("Complete")
    }

    public static func GetPrice(basket: [Int]) -> Double {
        var sets: [Set<Int>] = []

        for i in basket {
            // find first set in sets that doesn't hold i
            // print(sets)
            sets = sets.sorted {
                
                if ($0.count == 3 && $1.count > 3) {
                    // prefer the least populated, if we have a bag of 3
                    // more value in 4 discount than 5 if possible
                    return $0.count < $1.count
                }

                // prefer the more populated set (want to generally try and complete sets)
                return $0.count > $1.count
            }

            if let s = sets.firstIndex(where: { !$0.contains(i) }) {
                sets[s].insert(i)
            } else {
                var newSet: Set<Int> = Set<Int>()
                newSet.insert(i)
                sets.append(newSet)
            }
        }

        var totalCost: Double = 0
        for s in sets {
            let setCost = GetPrice(setOfBooks: s)
            //print(s, setCost)
            totalCost += setCost
        }
        
        return totalCost
    }

    private static func GetPrice(setOfBooks: Set<Int>) -> Double {
        let bookPrice = 8
        let standardPrice = Double(setOfBooks.count * bookPrice)
        let discountMultiplier = GetDiscount(uniqueBooks: setOfBooks.count)
        let discount = Double(standardPrice) * discountMultiplier
        let price = standardPrice - discount

        return price
    }

    private static func GetDiscount(uniqueBooks: Int) -> Double {
        switch(uniqueBooks) {
            case 2:
                return 0.05
            case 3:
                return 0.1
            case 4:
                return 0.2
            case 5:
                return 0.25
            default:
                return 0
        }
    }
}
