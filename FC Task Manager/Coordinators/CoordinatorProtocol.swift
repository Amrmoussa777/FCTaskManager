//
//  CoordinatorProtocol.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import Foundation



// base interface for all coordinators who are responsible for navigation through the app views.
protocol Coordinator{
    var childCoordinators:[Coordinator]{set get}
    func initialize()
}
