//
//  Solver.swift
//  NPuzzle_IDAstar
//
//  Created by Aline Borges on 26/08/16.
//  Copyright © 2016 Aline Borges. All rights reserved.
//

import Foundation
class IDASolver {
    
    /**
     Returns the minimum moves to solve an specific board
     */
    func minimumMoves(initialBoard initialBoard: Board) -> Int? {
        let boards = IDAstar(initialBoard)
        
        if (boards != nil) {
            for b in boards! {
                print(b.toString())
            }
            print("number of movements: \(boards!.count)")
        }
        
        return boards?.count
        
    }
    
    /*
     Finds the minimum path to goal using IDA*
    */
    func IDAstar(initialBoard: Board) -> [Board]? {
        var solved = false
        var board = initialBoard
        var bounds:Int = board.heuristic
        while(solved == false) {
            board = search(initialBoard, bounds: bounds)
            if (board.manhattanDistance == 0) {
                solved = true
                //the goal board was found, reconstruct path and  show results
                return reconstructPath(board)
            }
            bounds = board.heuristic
            print(bounds)
        }
        
    }
    
    //recursivelly search branches from starter board until the success or until it reaches the bounds marked before
    func search(board: Board, bounds: Int) -> Board {
        if (board.heuristic > bounds) {
            return board
        }
        //board was found
        if (board.manhattanDistance == 0) {
            return board
        }
        
        var hmin = Int.max
        var minBoard:Board = board
        
        let nextBoards = board.findNeighbors()
        
        for newBoard in nextBoards {
            newBoard.parent = board
            newBoard.numberOfSteps = board.numberOfSteps + 1
            //recursive call
            let b = search(newBoard, bounds: bounds)
            if (b.manhattanDistance == 0) {
                return b
            }
            if (b.heuristic < hmin) {
                hmin = b.heuristic
                minBoard = b
            }
        }
        
        return minBoard
        
    }
    
    //reconstruct the path to goal
    func reconstructPath(board: Board) -> [Board] {
        var boards:[Board] = []
        var b = board
        
        while (b.parent != nil) {
            boards.append(b)
            b = b.parent!
        }
        
        return boards.reverse()
    }
    
}
