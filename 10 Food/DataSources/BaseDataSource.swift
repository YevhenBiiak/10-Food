//
//  BaseDataSource.swift
//  10 Food
//
//  Created by Yevhen Biiak on 22.01.2023.
//

class DataSource<Model> {
    func obtainData(_ completion: ([Model]) -> Void) {
        fatalError("This is a base class that should be extended by your own implementation and the \(#function) method overridden.")
    }
}
