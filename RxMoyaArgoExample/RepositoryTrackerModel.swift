//
//  RepositoryTrackerModel.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-16.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Foundation
import Moya
import RxOptional
import RxSwift

struct RepositoryTrackerModel {

	let provider: RxMoyaProvider<GitHub>
	let username: Observable<String>

	func trackRepositories() -> Observable<[Repository]> {
		return username
			.observeOn(MainScheduler.instance)
			.flatMapLatest { username -> Observable<[Repository]?> in
				print("Username: \(username)")
				return self.findRepositories(username: username)
			}
			.replaceNilWith([])
	}

	internal func findRepositories(username: String) -> Observable<[Repository]?> {
		return provider
			.request(GitHub.repos(username: username))
			.debug()
			.mapArrayOptional(type: Repository.self)
	}
}
