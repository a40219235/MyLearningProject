//
//  CoreDataManager.h
//  AnimalRescue
//
//  Created by iMac on 3/17/13.
//
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property(nonatomic, retain, readonly) NSManagedObjectContext *moc;
@property(nonatomic, retain, readonly) NSManagedObjectModel *model;
@property(nonatomic, retain, readonly) NSPersistentStoreCoordinator *coordinator;

+(id)shared;

-(void)saveMoc;
-(NSURL *)storeDirectory;


@end
