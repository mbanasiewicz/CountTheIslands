func countIslands(_ input: [[Int]]) -> Int {
    guard !input.isEmpty else { return 0 }
    let width = input[0].count
    let height = input.count
    var islands = 0
    var visited = Set<Point>()
    
    struct Point: Hashable {
        let x: Int; let y: Int
    }
    
    func isValid(_ point: Point) -> Bool {
        return 0 <= point.x &&
        point.x < width &&
        0 <= point.y &&
        point.y < height
    }
    
    func neighbours(of point: Point) -> [Point] {
        [
            .init(x: point.x - 1, y: point.y + 1),
            .init(x: point.x, y: point.y + 1),
            .init(x: point.x + 1, y: point.y + 1),
            
            .init(x: point.x - 1 , y: point.y),
            .init(x: point.x + 1, y: point.y),
            
            .init(x: point.x - 1, y: point.y - 1),
            .init(x: point.x, y: point.y - 1),
            .init(x: point.x + 1, y: point.y - 1)
        ].filter {
            isValid($0)
        }
    }
    
    func value(_ point: Point) -> Int {
        input[point.y][point.x]
    }
    
    func bfs(point: Point) {
        guard !visited.contains(point) else { return }
        var queue: [Point] = [point]
        
        if !visited.contains(point), value(point) == 1 {
            islands += 1
        }
        
        while !queue.isEmpty {
            let currentElement = queue.removeFirst()
            if value(currentElement) == 1 {
                queue.append(contentsOf: neighbours(of: currentElement).filter { !visited.contains($0) })
            }
            
            visited.insert(currentElement)
        }
    }
    
    for row in (0..<height) {
        for column in (0..<width) {
            bfs(point: Point(x: column, y: row))
        }
    }
    
    return islands
}

let sampleInput = [
    [1, 1, 0],
    [0, 1, 0],
    [0, 1, 0],
    [0, 1, 0],
    [0, 0, 0],
    [1, 1, 0],
]

let sampleInput2 = [
    [1, 1, 0, 0, 0, 0],
    [1, 1, 0, 1, 0, 1],
    [1, 1, 0, 0, 0, 0],
    [1, 1, 0, 1, 0, 1],
    [1, 1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 0],
]

countIslands(sampleInput2)
