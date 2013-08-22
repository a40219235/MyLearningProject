//
//  GameObjectDetails.h
//  AnimalRescue
//
//  Created by iMac on 4/20/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameObjectInfo;

@interface GameObjectDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) GameObjectInfo *info;

@end
