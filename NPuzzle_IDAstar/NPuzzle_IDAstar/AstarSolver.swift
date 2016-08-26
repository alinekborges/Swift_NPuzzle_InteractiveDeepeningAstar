//
//  AstarSolver.swift
//  NPuzzle_IDAstar
//
//  Created by Aline Borges on 26/08/16.
//  Copyright © 2016 Aline Borges. All rights reserved.
//

import Foundation
class AStarSolver {
    
    var open:[Board] = [] //non examianted nodes
    var closed:[Board] = [] //examinated nodes
    
    //**********************
    // Starter variable
    var startBoard: Board!
    
    /**
     Returns the minimum moves to solve an specific board
     */
    func minimumMoves(initialBoard initialBoard: Board) -> Int? {
        self.startBoard = initialBoard
        open.removeAll()
        closed.removeAll()
        open.append(initialBoard)
        startBoard.numberOfSteps = 1
        let boards = aStarSearch()
        if (boards != nil) {
            for b in boards! {
                print(b.toString())
                print("heuristic: \(b.heuristic)")
            }
            print("Numero de movimentos: \(boards!.count)")
        }
        return boards?.count
        
    }
    
    //returns the path of boards used to find solution
    func aStarSearch() -> [Board]? {
        var count = 0
        while (!open.isEmpty) {
            let board = open.removeFirst()
            closed.append(board)
            //print(board.manhattanDistance, terminator: " ")
            if (board.manhattanDistance == 0) {
                //the goal board was found, reconstruct path and  show results
                return reconstructPath(board)
            } else {
                checkNewBoards(board)
            }
            
            count += 1
            if (count % 10 == 0) {
                print(".", terminator: "")
            }
        }
        
        //if it came to here, it is not possible to solve this board
        return nil
    }
    
    func checkNewBoards(board: Board) {
        let nextBoards = board.findNeighbors()
        for newBoard in nextBoards {
            if (!closed.contains(newBoard)) {
                newBoard.parent = board
                newBoard.numberOfSteps = board.numberOfSteps + 1
                if (open.contains(newBoard)) {
                    open.removeObject(newBoard)
                }
                self.open.append(newBoard)
            }
        }
        
        self.open.sortInPlace { $0.heuristic < $1.heuristic }
    }
    
    //reconstruct the path to
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
