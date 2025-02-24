//
//  LifePointsProtocol.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

typealias DidRunOutOfLifePointsEventHandler = (_ object: AnyObject) -> ()

protocol LifePointsProtocol {
    var lifePoints: Int { get set }
    var didRunOutOfLifePointsEventHandler: DidRunOutOfLifePointsEventHandler? { get set }
}
