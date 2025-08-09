//
//  PlaceRouter.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/18/25.
//

import Foundation
import Moya
import SwiftUI

enum PlaceRouter {
    case getGooglePlaceSearch(query: String) // 장소 검색으로 photo_reference 획득
    case getKakaoPlaceSearch(query: String) // 출발지 검색
    case getDirections(origin: String, destination: String) // 길찾기 검색
}

extension PlaceRouter: APITargetType {
    
    var baseURL: URL {
        switch self {
        case .getGooglePlaceSearch:
            return URL(string: "\(Config.googleApiURL)")!
        case .getKakaoPlaceSearch:
            return URL(string: "\(Config.kakaoApiURL)")!
        case .getDirections:
            return URL(string: "\(Config.destinationApiURL)")!
        }
    }
    
    var path: String {
        switch self {
        case .getGooglePlaceSearch:
            return "/textsearch/json"
        case .getKakaoPlaceSearch:
            return "/search/keyword.json"
        case .getDirections(let origin, let destination):
            return "/\(origin);\(destination)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGooglePlaceSearch, .getKakaoPlaceSearch, .getDirections:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getGooglePlaceSearch(let query):
            return .requestParameters(parameters: ["query": query, "key": "\(Config.apiKey)"], encoding: URLEncoding.queryString)
        case .getKakaoPlaceSearch(let query):
            return .requestParameters(parameters: ["query": query, "radius": 5, "page": 1, "size": 15], encoding: URLEncoding.queryString)
        case .getDirections:
            return .requestParameters(parameters: ["geometries": "geojson"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getKakaoPlaceSearch:
            return [
                "Content-Type": "application/json",
                "Authorization": "KakaoAK \(Config.restApiKey)"
            ]
        case .getGooglePlaceSearch, .getDirections:
            return ["Content-Type": "application/json"]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getGooglePlaceSearch:
            let jsonString = """
                {
                    "html_attributions": [],
                    "results": [
                        {
                            "business_status": "OPERATIONAL",
                            "formatted_address": "125 Yanghwa-ro, Mapo-gu, Seoul, South Korea",
                            "geometry": {
                                "location": {
                                    "lat": 37.554688,
                                    "lng": 126.92029
                                }
                            },
                            "name": "Starbucks Reserve Hongik University Station Intersection",
                            "photos": [
                                {
                                    "photo_reference": "AXQCQNTyXEKtSHY7w1ZhxSdr2ipwDTH4PiY4CmPidyeZD5czpe8NvUzJrrQhw6dbtcjMdpeWqem2zj4KrcTnl6GY0GIhymsXuxfI_QySBTigss-1GJGv3fkGaEovdK_q-hc0jLwFqa2O82CTbQTBzTltrRYJ6fnl7kjR118T8KMNROPPdFNXEAtbul7AxzY2Sw52cyNY2DidRmanA030epeec1p2hLCc-ppQe68UmYWlUNAqG7dn4QCDW0aQpusxbtymU6UhwI-vt_Ie3b7nwZR_prOxIz2tZGSTz5DEcDIiogB-ZdQgDzGK2YGc7AJ8DEMWanC3mf5LoHqhiPxjn8dMUupw7Pu4MmZflb-jpUavS8br2kQumRiyDMukUtH_pA33pYhpEbOBuwHjOyXrobG03yXNVr4G1sBFGRK767L2e_P8lokIZYQvPsy3pw5zlBQiTd9JAvDjYmi0Kc6ZUgl2VjSlIsahcrYPVfHvFgdrmmGMOBN1mT0zFOr_RanSTKNDpPiQqVgrnsH6q_bFiC135nTpe7NSsh0XvcEmKYMRBbOYkwn-OpYITS4wm2pOuJ0qiD17Bmkj",
                                    "height": 3024,
                                    "width": 3024
                                }
                            ],
                            "place_id": "ChIJKTrxZtuYfDURedaPlYRpMPE"
                        }
                    ],
                    "status": "OK"
                }
                """
            return Data(jsonString.utf8)
        case .getKakaoPlaceSearch:
            let jsonString = """
            {
                "documents": [
                    {
                        "address_name": "서울 마포구 상수동 329-7",
                        "category_group_code": "FD6",
                        "category_group_name": "음식점",
                        "category_name": "음식점 > 술집 > 실내포장마차",
                        "distance": "",
                        "id": "1125737806",
                        "phone": "02-336-9212",
                        "place_name": "상수포차 상수역점",
                        "place_url": "http://place.map.kakao.com/1125737806",
                        "road_address_name": "서울 마포구 와우산로 30",
                        "x": "126.923168328567",
                        "y": "37.547161195354"
                    },
                    {
                        "address_name": "서울 마포구 서교동 408-12",
                        "category_group_code": "",
                        "category_group_name": "",
                        "category_name": "가정,생활 > 미용 > 미용실",
                        "distance": "",
                        "id": "494443742",
                        "phone": "02-332-3650",
                        "place_name": "열두달오늘 상수역점",
                        "place_url": "http://place.map.kakao.com/494443742",
                        "road_address_name": "서울 마포구 어울마당로 52-1",
                        "x": "126.92114800682928",
                        "y": "37.54969076828841"
                    },
                    {
                        "address_name": "서울 마포구 상수동 93-87",
                        "category_group_code": "",
                        "category_group_name": "",
                        "category_name": "가정,생활 > 드럭스토어 > 올리브영",
                        "distance": "",
                        "id": "26512827",
                        "phone": "02-3144-0490",
                        "place_name": "올리브영 상수역점",
                        "place_url": "http://place.map.kakao.com/26512827",
                        "road_address_name": "서울 마포구 와우산로 49",
                        "x": "126.92287001765563",
                        "y": "37.54893686904782"
                    }
                ],
                "meta": {
                    "is_end": false,
                    "pageable_count": 38,
                    "same_name": {
                        "keyword": "상수역점",
                        "region": [],
                        "selected_region": ""
                    },
                    "total_count": 38
                }
            }
            """
            return Data(jsonString.utf8)
        case .getDirections:
            let jsonString = """
            {"code":"Ok","routes":[{"geometry":{"coordinates":[[126.960143,37.506969],[126.960223,37.507487],[126.958067,37.508064],[126.955552,37.509627],[126.954803,37.511285],[126.955235,37.512098],[126.954929,37.512564],[126.956155,37.51357],[126.958525,37.516837],[126.958612,37.517158],[126.958371,37.517112],[126.961389,37.521973],[126.961296,37.522287],[126.96055,37.522567],[126.960546,37.523183],[126.956545,37.525794],[126.954957,37.527671],[126.954454,37.52988],[126.954723,37.531053],[126.955384,37.531829],[126.955155,37.532174],[126.952807,37.532395],[126.95056,37.533179],[126.950601,37.53408],[126.948979,37.534589],[126.947416,37.536117],[126.947455,37.538726],[126.945565,37.539229],[126.94505,37.538846],[126.9387,37.543356],[126.937161,37.543667],[126.934871,37.544997],[126.931937,37.545565],[126.928459,37.545646],[126.927966,37.545988],[126.926615,37.546059],[126.926014,37.547048],[126.926055,37.547678],[126.923801,37.547744],[126.923346,37.547432]],"type":"LineString"},"legs":[{"steps":[],"summary":"","weight":5347.7,"duration":5347.7,"distance":7427.9}],"weight_name":"duration","weight":5347.7,"duration":5347.7,"distance":7427.9}],"waypoints":[{"hint":"p2NZgA5kWYCVAAAAfgAAADIBAAATAAAAox2mQQVAi0HXHSpC9E8mQJUAAAB-AAAAMgEAABMAAAABAAAAD0KRB5lPPALNRJEHRU88AgMAzwsJnVVD","distance":62.750389779,"name":"흑석로10길","location":[126.960143,37.506969]},{"hint":"oghHgKUIR4AAAAAAfQAAAAAAAAAAAAAAAAAAAM50ikEAAAAAAAAAAAAAAAB9AAAAAAAAAAAAAAABAAAAUrKQB6jtPALQsZAH2u08AgAAPwgJnVVD","distance":12.761251721,"name":"독막로","location":[126.923346,37.547432]}]}
            """
            return Data(jsonString.utf8)
        }
    }
}
