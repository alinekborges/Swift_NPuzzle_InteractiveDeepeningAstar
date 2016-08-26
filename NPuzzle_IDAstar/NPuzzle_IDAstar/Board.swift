//
//  Board.swift
//  NPuzzle_IDAstar
//
//  Created by Aline Borges on 26/08/16.
//  Copyright © 2016 Aline Borges. All rights reserved.
//

import Foundation
class Board: Equatable {
    //********************************
    var tiles:[[Int]]!
    //Used to reconstruct the path
    var parent: Board?
    //number of steps needed to get to here
    var numberOfSteps: Int = 0
    //********************************
    //returns the manhattan distance to goal
    private var _manhattanDistance: Int = -1
    var manhattanDistance: Int {
        get {
            if (self._manhattanDistance == -1) {
                self._manhattanDistance = calculateManhattanDistance()
            }
            return self._manhattanDistance
        }
    }
    
    //returns the heuristic to calculate the path
    // heuristic is the manhattanDistance to goal + number of steps needed
    var _heuristic: Int = 0
    var heuristic: Int {
        get {
            self._heuristic = self.manhattanDistance + numberOfSteps
            return self._heuristic
        }
    }
    
    //size of the board
    var size:Int {
        return self.tiles.count
    }
    
    var _spacePosition: (x: Int, y:Int)?
    //returns the position of the space given board
    var spacePosition: (x: Int, y:Int) {
        get {
            if (_spacePosition == nil) {
                _spacePosition = self.findSpacePosition()
            }
            return _spacePosition!
        }
    }
    
    //****************************************
    // MARK: Methods
    
    //initializer
    init(tilesMatrix: [[Int]]) {
        tiles = tilesMatrix
    }
    
    /**
     Finds all possible neighbors for this board.
     It will check each possible movement (left, right, up, down) and avoid
     going back to the parent board
     
     - returns: An array of the neighbor boards
     */
    func findNeighbors() -> [Board] {
        var boards:[Board] = []
        let space = spacePosition
        let max = size - 1
        if (space.x != 0) {
            let b = moveLeft(space)
            if (self.parent != b) {
                b.parent = self
                b.numberOfSteps = self.numberOfSteps + 1
                boards.append(b)
            }
        }
        if (space.x != max) {
            let b = moveRight(space)
            if (self.parent != b) {
                b.parent = self
                b.numberOfSteps = self.numberOfSteps + 1
                boards.append(b)
            }
        }
        if (space.y != 0) {
            let b = moveUp(space)
            if (self.parent != b) {
                b.parent = self
                b.numberOfSteps = self.numberOfSteps + 1
                boards.append(b)
            }
        }
        if (space.y != max) {
            let b = moveDown(space)
            if (self.parent != b) {
                b.parent = self
                b.numberOfSteps = self.numberOfSteps + 1
                boards.append(b)
            }
        }
        
        return boards
    }
    
    
    func moveLeft(pos: (x: Int, y: Int)) -> Board {
        var newTiles = self.tiles
        newTiles[pos.y][pos.x] = self.tiles[pos.y][pos.x - 1]
        newTiles[pos.y][pos.x - 1] = 0
        return Board(tilesMatrix: newTiles)
    }
    
    func moveRight(pos: (x: Int, y: Int)) -> Board {
        var newTiles = self.tiles
        newTiles[pos.y][pos.x] = self.tiles[pos.y][pos.x + 1]
        newTiles[pos.y][pos.x + 1] = 0
        return Board(tilesMatrix: newTiles)
    }
    
    func moveUp(pos: (x: Int, y: Int)) -> Board {
        var newTiles = self.tiles
        newTiles[pos.y][pos.x] = self.tiles[pos.y - 1][pos.x]
        newTiles[pos.y - 1][pos.x] = 0
        return Board(tilesMatrix: newTiles)
    }
    
    func moveDown(pos: (x: Int, y: Int)) -> Board {
        var newTiles = self.tiles
        newTiles[pos.y][pos.x] = self.tiles[pos.y + 1][pos.x]
        newTiles[pos.y + 1][pos.x] = 0
        return Board(tilesMatrix: newTiles)
    }
    
    /**
     Find the space position, in this example represented by the number 0
     
     - returns: position of the space
     */
    func findSpacePosition() -> (x: Int, y: Int) {
        let size = self.tiles[0].count - 1
        for x in 0...size {
            for y in 0...size {
                if (self.tiles[y][x] == 0){
                    return (x: x, y: y)
                }
            }
        }
        return (x: 0, y: 0)
    }
    
    /*
     Returns the manhattan distance between each number and it's right position
     */
    func calculateManhattanDistance() -> Int {
        var distance:Int = 0
        let size = self.tiles[0].count
        for y in 0...size-1 {
            for x in 0...size-1 {
                let n = self.tiles[y][x]
                if (n != 0) {
                    let from = (x: x, y: y)
                    let to = self.correctPositionForNumber(n)
                    distance += findManhattanDistance(from: from, to: to)
                }
            }
        }
        return distance
    }
    
    /**
     Returns the correct position for the current board
     
     - parameter n:    number
     
     - returns: position
     */
    private func correctPositionForNumber(n: Int) -> (x: Int, y: Int) {
        
        return (x: (n - 1) % self.size, y: (n - 1) / self.size)
    }
    
    /**
     Checks if this board is equal to another board (used to order array)
     
     - parameter board: board to compare
     
     - returns: boolean value
     */
    func isEqualToBoard(board: Board) -> Bool {
        let size = board.tiles[0].count - 1
        for line in 0...size {
            for collumn in 0...size {
                if (self.tiles[collumn][line] != board.tiles[collumn][line]) {
                    return false
                }
            }
        }
        return true
    }
    
    /**
     Calculates integer manhattanDistance from one point to another
     
     - parameter from: from
     - parameter to:   to
     
     - returns: returns the integer distance calculated`
     */
    func findManhattanDistance(from from: (x: Int, y: Int), to: (x: Int, y: Int)) -> Int {
        return (abs(from.x - to.x) + abs(from.y - to.y));
    }
    
    func toString() {
        for line in self.tiles {
            print(line)
        }
    }
}

//***************************************
//Implementing Equatable protocol
func == (lhs: Board, rhs: Board) -> Bool {
    return lhs.isEqualToBoard(rhs)
}

