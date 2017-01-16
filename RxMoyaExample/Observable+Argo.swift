//
//  Observable+Argo.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-15.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Moya
import RxSwift
import Argo

public extension ObservableType where E == Response {
	public func mapObject<T: Decodable>(type: T.Type, keyPath: String? = nil) -> Observable<T> where T == T.DecodedType {
		return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
			.flatMap { response -> Observable<T> in
				return Observable.just(try response.mapObject(withKeyPath: keyPath))
			}
			.observeOn(MainScheduler.instance)
	}

	public func mapArray<T: Decodable>(type: T.Type, keyPath: String? = nil) -> Observable<[T]> where T == T.DecodedType {
		return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
			.flatMap { response -> Observable<[T]> in
				return Observable.just(try response.mapArray(withKeyPath: keyPath))
			}
			.observeOn(MainScheduler.instance)
	}

	public func mapObjectOptional<T: Decodable>(type: T.Type, keyPath: String? = nil) -> Observable<T?> where T == T.DecodedType {
		return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
			.flatMap { response -> Observable<T?> in
				do {
					let object: T = try response.mapObject(withKeyPath: keyPath)
					return Observable.just(object)
				} catch {
					return Observable.just(nil)
				}

			}
			.observeOn(MainScheduler.instance)
	}

	public func mapArrayOptional<T: Decodable>(type: T.Type, keyPath: String? = nil) -> Observable<[T]?> where T == T.DecodedType {
		return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
			.flatMap { response -> Observable<[T]?> in
				do {
					let object: [T] = try response.mapArray(withKeyPath: keyPath)
					return Observable.just(object)
				} catch {
					return Observable.just(nil)
				}
			}
			.observeOn(MainScheduler.instance)
	}
}
