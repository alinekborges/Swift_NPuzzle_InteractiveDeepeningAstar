//
//  Extensions.swift
//  NPuzzle_IDAstar
//
//  Created by Aline Borges on 26/08/16.
//  Copyright © 2016 Aline Borges. All rights reserved.
//

import Foundation

//*******************************************
//Extra stuff for swift
extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

extension CGPoint {
    func manhattanDistanceTo(to: CGPoint) -> CGFloat {
        return (abs(self.x - to.x) + abs(self.y - to.y));
    }
}