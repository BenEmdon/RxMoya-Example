//
//  GitHubEndpoint.swift
//  RxMoyaExample
//
//  Created by Benjamin Emdon on 2017-01-12.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Foundation
import Moya

private extension String {
	var URLEscapedString: String {
		return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}
}

enum GitHub {
	case userProfile(username: String)
	case repos(username: String)
	case repo(fullname: String)
	case issues(repositoryFullName: String)
}

extension GitHub: TargetType {
	var baseURL: URL { return URL(string: "https://api.github.com")! }

	var path: String {
		switch self {
		case .repos(let name):
			return "/users/\(name.URLEscapedString)/repos"
		case .userProfile(let name):
			return "/users/\(name.URLEscapedString)"
		case .repo(let name):
			return "/repos/\(name)"
		case .issues(let repositoryName):
			return "/repos/\(repositoryName)/issues"
		}
	}

	var method: Moya.Method {
		return .get
	}

	var parameters: [String: Any]? {
		switch self {
		case .repos(_):
			return ["sort": "pushed"]
		default:
			return nil
		}
	}

	var parameterEncoding: ParameterEncoding {
		return URLEncoding.default
	}

	var task: Task {
		return .request
	}

	var sampleData: Data {
		switch self {
		case .repos(_):
			return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}}}".data(using: .utf8)!
		case .userProfile(let name):
			return "{\"login\": \"\(name)\", \"id\": 100}".data(using: .utf8)!
		case .repo(_):
			return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: .utf8)!
		case .issues(_):
			return "{\"id\": 132942471, \"number\": 405, \"title\": \"Updates example with fix to String extension by changing to Optional\", \"body\": \"Fix it pls.\"}".data(using: .utf8)!
		}
	}
}
