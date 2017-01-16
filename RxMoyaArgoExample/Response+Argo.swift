//
//  Response+Argo.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-15.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Foundation
import Moya
import Argo

public extension Response {

	public func mapObject<T:Decodable>() throws -> T where T == T.DecodedType {
		guard let jsonDictionary = try mapJSON() as? NSDictionary, let object: T = decode(jsonDictionary) else {
			throw MoyaError.jsonMapping(self)
		}
		return object
	}

	public func mapObject<T: Decodable>(withKeyPath keyPath: String?) throws -> T where T == T.DecodedType {
		guard let keyPath = keyPath else { return try mapObject() }

		guard let jsonDictionary = try mapJSON() as? NSDictionary,
			let objectDictionary = jsonDictionary.value(forKeyPath: keyPath) as? NSDictionary,
			let object: T = decode(objectDictionary) else {
				throw MoyaError.jsonMapping(self)
		}
		return object
	}

	public func mapArray<T: Decodable>() throws -> [T] where T == T.DecodedType {
		guard let jsonArray = try mapJSON() as? NSArray, let object: [T] = decode(jsonArray) else {
			throw MoyaError.jsonMapping(self)
		}

		return object
	}

	public func mapArray<T: Decodable>(withKeyPath keyPath: String?) throws -> [T] where T == T.DecodedType {
		guard let keyPath = keyPath else { return try mapArray() }

		guard let jsonDictionary = try mapJSON() as? NSDictionary,
			let objectArray = jsonDictionary.value(forKeyPath:keyPath) as? NSArray,
			let object: [T] = decode(objectArray) else {
				throw MoyaError.jsonMapping(self)
		}

		return object
	}
}
