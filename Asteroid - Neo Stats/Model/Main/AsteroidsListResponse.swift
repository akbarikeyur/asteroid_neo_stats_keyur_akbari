//
//  AsteroidsListResponse.swift
//  Asteroid - Neo Stats
//
//  Created by Keyur on 07/09/22.
//
import Foundation

// MARK: - Welcome
struct AsteroidsListResponse: Codable {
    let links: WelcomeLinks?
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]

    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        links = try values.decodeIfPresent(WelcomeLinks.self, forKey: .links) ?? nil
        elementCount = try values.decodeIfPresent(Int.self, forKey: .elementCount) ?? DocumentDefaultValues.Empty.int
        nearEarthObjects = try values.decodeIfPresent([String: [NearEarthObject]].self, forKey: .nearEarthObjects) ?? [String: [NearEarthObject]]()
        
    }
    
    init() {
        links = nil
        elementCount = DocumentDefaultValues.Empty.int
        nearEarthObjects = [String: [NearEarthObject]]()
    }
    
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let next, previous, linksSelf: String

    enum CodingKeys: String, CodingKey {
        case next, previous
        case linksSelf = "self"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        next = try values.decodeIfPresent(String.self, forKey: .next) ?? DocumentDefaultValues.Empty.string
        previous = try values.decodeIfPresent(String.self, forKey: .previous) ?? DocumentDefaultValues.Empty.string
        linksSelf = try values.decodeIfPresent(String.self, forKey: .linksSelf) ?? DocumentDefaultValues.Empty.string
    }
    
    init()  {
        next = DocumentDefaultValues.Empty.string
        previous = DocumentDefaultValues.Empty.string
        linksSelf = DocumentDefaultValues.Empty.string
    }
    
}

// MARK: - NearEarthObject
struct NearEarthObject: Codable {
    let links: NearEarthObjectLinks?
    let id, neoReferenceID, name: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter?
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    let isSentryObject: Bool

    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        links = try values.decodeIfPresent(NearEarthObjectLinks.self, forKey: .links) ?? nil
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? DocumentDefaultValues.Empty.string
        neoReferenceID = try values.decodeIfPresent(String.self, forKey: .neoReferenceID) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
        nasaJplURL = try values.decodeIfPresent(String.self, forKey: .nasaJplURL) ?? DocumentDefaultValues.Empty.string
        absoluteMagnitudeH = try values.decodeIfPresent(Double.self, forKey: .absoluteMagnitudeH) ?? DocumentDefaultValues.Empty.double
        estimatedDiameter = try values.decodeIfPresent(EstimatedDiameter.self, forKey: .estimatedDiameter) ?? nil
        isPotentiallyHazardousAsteroid = try values.decodeIfPresent(Bool.self, forKey: .isPotentiallyHazardousAsteroid) ?? DocumentDefaultValues.Empty.bool
        closeApproachData = try values.decodeIfPresent([CloseApproachDatum].self, forKey: .closeApproachData) ?? []
        isSentryObject = try values.decodeIfPresent(Bool.self, forKey: .isSentryObject) ?? DocumentDefaultValues.Empty.bool
        
    }
    
    init() {
        
        links =  nil
        id = DocumentDefaultValues.Empty.string
        neoReferenceID = DocumentDefaultValues.Empty.string
        name =  DocumentDefaultValues.Empty.string
        nasaJplURL = DocumentDefaultValues.Empty.string
        absoluteMagnitudeH = DocumentDefaultValues.Empty.double
        estimatedDiameter = nil
        isPotentiallyHazardousAsteroid = DocumentDefaultValues.Empty.bool
        closeApproachData = []
        isSentryObject = DocumentDefaultValues.Empty.bool
        
    }
    
}

// MARK: - CloseApproachDatum
struct CloseApproachDatum: Codable {
    let closeApproachDate, closeApproachDateFull: String
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity?
    let missDistance: MissDistance?
    let orbitingBody: String?

    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        closeApproachDate = try values.decodeIfPresent(String.self, forKey: .closeApproachDate) ?? DocumentDefaultValues.Empty.string
        closeApproachDateFull = try values.decodeIfPresent(String.self, forKey: .closeApproachDateFull) ?? DocumentDefaultValues.Empty.string
        epochDateCloseApproach = try values.decodeIfPresent(Int.self, forKey: .epochDateCloseApproach) ?? DocumentDefaultValues.Empty.int
        relativeVelocity = try values.decodeIfPresent(RelativeVelocity.self, forKey: .relativeVelocity) ?? nil
        missDistance = try values.decodeIfPresent(MissDistance.self, forKey: .missDistance) ?? nil
        orbitingBody = try values.decodeIfPresent(String.self, forKey: .orbitingBody) ?? nil
        
    }
    
    init()  {
        
        closeApproachDate = DocumentDefaultValues.Empty.string
        closeApproachDateFull = DocumentDefaultValues.Empty.string
        epochDateCloseApproach = DocumentDefaultValues.Empty.int
        relativeVelocity = nil
        missDistance = nil
        orbitingBody = DocumentDefaultValues.Empty.string
        
    }
    
}

// MARK: - MissDistance
struct MissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        astronomical = try values.decodeIfPresent(String.self, forKey: .astronomical) ?? DocumentDefaultValues.Empty.string
        lunar = try values.decodeIfPresent(String.self, forKey: .lunar) ?? DocumentDefaultValues.Empty.string
        kilometers = try values.decodeIfPresent(String.self, forKey: .kilometers) ?? DocumentDefaultValues.Empty.string
        miles = try values.decodeIfPresent(String.self, forKey: .miles) ?? DocumentDefaultValues.Empty.string
    }
    
    init()  {
        
        astronomical = DocumentDefaultValues.Empty.string
        lunar = DocumentDefaultValues.Empty.string
        kilometers = DocumentDefaultValues.Empty.string
        miles = DocumentDefaultValues.Empty.string
    }
}


// MARK: - RelativeVelocity
struct RelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kilometersPerSecond = try values.decodeIfPresent(String.self, forKey: .kilometersPerSecond) ?? DocumentDefaultValues.Empty.string
        kilometersPerHour = try values.decodeIfPresent(String.self, forKey: .kilometersPerHour) ?? DocumentDefaultValues.Empty.string
        milesPerHour = try values.decodeIfPresent(String.self, forKey: .milesPerHour) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        
        kilometersPerSecond = DocumentDefaultValues.Empty.string
        kilometersPerHour = DocumentDefaultValues.Empty.string
        milesPerHour = DocumentDefaultValues.Empty.string
    }
    
}

// MARK: - EstimatedDiameter
struct EstimatedDiameter: Codable {
    let kilometers, meters, miles, feet: Feet
}

// MARK: - Feet
struct Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        estimatedDiameterMin = try values.decodeIfPresent(Double.self, forKey: .estimatedDiameterMin) ?? DocumentDefaultValues.Empty.double
        estimatedDiameterMax = try values.decodeIfPresent(Double.self, forKey: .estimatedDiameterMax) ?? DocumentDefaultValues.Empty.double
    }
    
    init()  {
        
        estimatedDiameterMin = DocumentDefaultValues.Empty.double
        estimatedDiameterMax = DocumentDefaultValues.Empty.double
    }
    
    
    
}

// MARK: - NearEarthObjectLinks
struct NearEarthObjectLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        linksSelf = try values.decodeIfPresent(String.self, forKey: .linksSelf) ?? DocumentDefaultValues.Empty.string
    }
    
    init()  {
        
        linksSelf = DocumentDefaultValues.Empty.string
    }
    
}
