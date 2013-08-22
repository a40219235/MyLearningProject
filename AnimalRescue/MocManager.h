//
//  MocManager.h
//  AnimalRescue
//
//  Created by iMac on 3/17/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MocManager : NSObject
{
    NSManagedObjectContext *_moc;
}

-(NSArray *)fetchGameObjectsInfo;
-(NSArray *)fetchGameObjectsDetails;
-(void)insertpoints:(int)points toSkill:(int)number;
-(void)insertChapter:(int)points toChapter:(int)number;
-(void)deleteGameObjects:(NSManagedObject*)gameObjects;
-(void)commitChanges;

@end