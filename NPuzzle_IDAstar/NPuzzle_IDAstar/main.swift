//
//  main.swift
//  N-Puzzle solver using Swift
//  Interactive-Deepening A *
//  Created by Aline Borges on 26/08/16.
//  Copyright © 2016 Aline Borges. All rights reserved.
//

import Foundation



//********************************
// TEST CASES
let test = [[0,1,3],[4,2,5],[7,8,6]]
//let test = [[5,1,7,3],[9,2,11,4],[13,6,15,8],[0,10,14,12]]
//let test = [[5,8,7,11],[1,6,12,2],[9,0,13,10],[14,3,4,15]]
//let test = [[5,1,6,4],[9,0,11,15],[10,2,8,14],[13,3,12,7]]


//*************************************
//0 is representing the empty space
let idaSolver = IDASolver()
let aStarSolver = AStarSolver()
let board = Board(tilesMatrix: test)


idaSolver.minimumMoves(initialBoard: board)
//aStarSolver.minimumMoves(initialBoard: board)






