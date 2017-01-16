//
//  Repository.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-13.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Mapper

struct Repository: Mappable {

	let identifier: Int
	let language: String
	let name: String
	let fullName: String

	init(map: Mapper) throws {
		try identifier = map.from("id")
		try language = map.from("language")
		try name = map.from("name")
		try fullName = map.from("full_name")
	}
}

