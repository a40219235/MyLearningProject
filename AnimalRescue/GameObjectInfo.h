//
//  GameObjectInfo.h
//  AnimalRescue
//
//  Created by iMac on 4/20/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameObjectDetails;

@interface GameObjectInfo : NSManagedObject

@property (nonatomic, retain) NSString * chapter;
@property (nonatomic, retain) NSNumber * skill;
@property (nonatomic, retain) GameObjectDetails *details;

@end
