//
//  Issue.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-13.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Argo
import Runes
import Curry

struct Issue {

	let identifier: Int
	let number: Int
	let title: String
	let body: String

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
