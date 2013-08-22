//
//  BoomerangUltimateAction.m
//  AnimalRescue
//
//  Created by iMac on 4/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BoomerangUltimateAction.h"


@implementation BoomerangUltimateAction

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    ActionSprite *bullet = [actionSprite.layer createBulletClass:actionSprite.bulletClass ForTeam:actionSprite.isAlly withActor:NO actionSprite:actionSprite];
    bullet.laserPenetrationAbility = YES;
    
    direction = ccp(1,0);
    
    //moveforward Action
    CCRotateBy *rotateForward = [CCRotateBy actionWithDuration:5 angle:-2600 * 5];
    CCMoveBy *moveForward = [CCMoveBy actionWithDuration:2 position:ccpMult(direction, 350)];
    CCEaseExponentialOut *exponentialForward= [CCEaseExponentialOut actionWithAction:moveForward];
    CCSpawn *spawnForward = [CCSpawn actions:rotateForward, exponentialForward, nil];
    //fly back delay
    CCDelayTime *delayTime = [CCDelayTime actionWithDuration:0.7];
    //reset aoe ability delay
    CCDelayTime *delayTime1 = [CCDelayTime actionWithDuration:1.2];
    //delete delay
    CCDelayTime *delayTime2 = [CCDelayTime actionWithDuration:2.7];
    //move back action
    CCMoveTo *moveBack = [CCMoveTo actionWithDuration:2 position:actionSprite.position];
    CCEaseExponentialIn *exponentialBack = [CCEaseExponentialIn actionWithAction:moveBack];
    CCSpawn *spawnBack = [CCSpawn actions:rotateForward, exponentialBack, nil];
    
    //move forward
    [bullet runAction:spawnForward];
    //move back
    [bullet runAction:[CCSequence actions:delayTime, spawnBack, nil]];
    //reset aoe
    [bullet runAction:[CCSequence actions:delayTime1, [CCCallBlock actionWithBlock:^{bullet.laserPenetrationCheck = 0;}], nil]];
    //delete
    [bullet runAction:[CCSequence actions:delayTime2, [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
}

@end
