//
//  MocManager.m
//  AnimalRescue
//
//  Created by iMac on 3/17/13.
//
//

#import "MocManager.h"
#import "CoreDataManager.h"

#import "GameObjectInfo.h"
#import "GameObjectDetails.h"
@implementation MocManager

-(id)init
{
    if ((self = [super init]))
    {
        _moc = [[CoreDataManager shared] moc];
        [self printPathToStore];
    }
    return self;
}

-(void)commitChanges
{
    [[CoreDataManager shared] saveMoc];
}

-(void)insertpoints:(int)points toSkill:(int)number
{
    GameObjectInfo *gameObjectInfo = [NSEntityDescription insertNewObjectForEntityForName:@"GameObjectInfo" inManagedObjectContext:_moc];
    gameObjectInfo.skill = [NSNumber numberWithInt:number];
    
    GameObjectDetails *gameObjectDetails = [NSEntityDescription insertNewObjectForEntityForName:@"GameObjectDetails" inManagedObjectContext:_moc];
    gameObjectDetails.points = [NSNumber numberWithInt:points];
    
    gameObjectInfo.details = gameObjectDetails;
    gameObjectDetails.info = gameObjectInfo;
}

-(void)insertChapter:(int)points toChapter:(int)number
{
    GameObjectInfo *gameObjectInfo = [NSEntityDescription insertNewObjectForEntityForName:@"GameObjectInfo" inManagedObjectContext:_moc];
    gameObjectInfo.chapter = [NSString stringWithFormat:@"chapter%d",number];
    
    GameObjectDetails *gameObjectDetails = [NSEntityDescription insertNewObjectForEntityForName:@"GameObjectDetails" inManagedObjectContext:_moc];
    gameObjectDetails.points = [NSNumber numberWithInt:points];
    
    gameObjectInfo.details = gameObjectDetails;
    gameObjectDetails.info = gameObjectInfo;
}

-(void)deleteGameObjects:(NSManagedObject *)gameObjects
{
    [_moc deleteObject:gameObjects];
}

-(NSArray *)fetchGameObjectsInfo
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GameObjectInfo" inManagedObjectContext:_moc];
    [fetchRequest setEntity:entity];
    return [_moc executeFetchRequest:fetchRequest error:&error];
}

-(NSArray *)fetchGameObjectsDetails
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GameObjectDetails" inManagedObjectContext:_moc];
    [fetchRequest setEntity:entity];
    return [_moc executeFetchRequest:fetchRequest error:&error];
}

-(void)printPathToStore
{
    NSLog(@"URL is %@", [[CoreDataManager shared] storeDirectory].path);
}

@end
