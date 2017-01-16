//
//  Repository.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-13.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Mapper
import Argo
import Runes
import Curry

struct Repository {

	let identifier: Int
	let language: String
	let name: String
	let fullName: String

//	init(map: Mapper) throws {
//		try identifier = map.from("id")
//		try language = map.from("language")
//		try name = map.from("name")
//		try fullName = map.from("full_name")
//	}
}

extension Repository: Decodable {
	static func decode(_ json: JSON) -> Decoded<Repository> {
		return curry(Repository.init)
		<^> json <| "id"
		<*> json <| "language"
		<*> json <| "name"
		<*> json <| "full_name"
	}
}

