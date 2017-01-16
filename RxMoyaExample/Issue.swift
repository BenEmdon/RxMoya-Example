//
//  Issue.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-13.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//


//import Mapper
import Argo
import Runes
import Curry

struct Issue {

	let identifier: Int
	let number: Int
	let title: String
	let body: String

//	init(map: Mapper) throws {
//		try identifier = map.from("id")
//		try number = map.from("number")
//		try title = map.from("title")
//		try body = map.from("body")
//	}
}
extension Issue: Decodable {
	static func decode(_ json: JSON) -> Decoded<Issue> {
		return curry(Issue.init)
		<^> json <| "id"
		<*> json <| "number"
		<*> json <| "title"
		<*> json <| "body"
	}
}
