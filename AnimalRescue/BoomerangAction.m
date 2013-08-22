//
//  BoomerangAction.m
//  AnimalRescue
//
//  Created by iMac on 4/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BoomerangAction.h"


@implementation BoomerangAction

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    ActionSprite *bullet = [actionSprite.layer createBulletClass:actionSprite.bulletClass ForTeam:actionSprite.isAlly withActor:NO actionSprite:actionSprite];
    bullet.boomerangBulletInitPosition = actionSprite.position;
    
    direction = ccp(1,0);
    
    //temp
    bullet.bulletActionType =kbulletActionBoomerang;
    
    CCRotateBy *rotateBy = [CCRotateBy actionWithDuration:1 angle:2600];
    CCMoveBy *moveBy= [CCMoveBy actionWithDuration:1 position:ccpMult(direction, 300)];
    CCSpawn *spwanAction = [CCSpawn actions:rotateBy, moveBy, nil];
    
    [bullet runAction:[CCSequence actions:spwanAction, [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
}
@end
