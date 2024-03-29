//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Jared Pateman on 10/09/2023.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedAbout: String {
        about ?? "Unknown"
    }
    
    var wrappedAddress: String {
        address ?? "Unknown"
    }
    
    var wrappedCompany: String {
        company ?? "Unknown"
    }
    
    var wrappedEmail: String {
        email ?? "Unknown"
    }
    
    var wrappedName: String {
        name ?? "Unknown"
    }
    
    var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    var wrappedTags: String {
        tags ?? "Unknown"
    }
    
    public var friendsList: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
