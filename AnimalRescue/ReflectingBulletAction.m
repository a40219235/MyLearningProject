//
//  ReflectingBulletAction.m
//  AnimalRescue
//
//  Created by iMac on 4/21/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ReflectingBulletAction.h"


@implementation ReflectingBulletAction

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    for (int i = 0; i< 5; i++)
    {
    ActionSprite* bullet_ = [actionSprite.layer createBulletClass:actionSprite.bulletClass ForTeam:actionSprite.isAlly withActor:NO actionSprite:actionSprite];
        bullet_.isReflectingBullet = YES;
    bullet_.bulletAngle = CCRANDOM_MINUS1_1() * 80;
    bullet_.rotation = -bullet_.bulletAngle;
    direction = ccpForAngle(CC_DEGREES_TO_RADIANS(bullet_.bulletAngle));
    CCMoveBy *moveBy= [CCMoveBy actionWithDuration:3 position:ccpMult(direction, 600)];
    
    [bullet_ runAction:moveBy];
    }
}

-(void)updateBouncing:(ActionSprite *)actionSprite
{
    if (actionSprite.position.x >= actionSprite.layer.winSize.width && !actionSprite.forward) {
        actionSprite.bulletAngle = 180 - actionSprite.bulletAngle;
        actionSprite.rotation = -actionSprite.bulletAngle;
        CGPoint direction = ccpForAngle(CC_DEGREES_TO_RADIANS(actionSprite.bulletAngle));
        CCMoveBy *moveBy= [CCMoveBy actionWithDuration:3 position:ccpMult(direction, 700)];
        [actionSprite runAction:moveBy];
        actionSprite.forward = YES;
        actionSprite.backward = actionSprite.up = actionSprite.down = NO;
        actionSprite.reflectingCount ++;
        //reset AOE count
        actionSprite.laserPenetrationCheck = 0;
    }
    if (actionSprite.position.x <= 0 && !actionSprite.backward) {
        actionSprite.bulletAngle = 180 - actionSprite.bulletAngle;
        actionSprite.rotation = -actionSprite.bulletAngle;
        CGPoint direction = ccpForAngle(CC_DEGREES_TO_RADIANS(actionSprite.bulletAngle));
        CCMoveBy *moveBy= [CCMoveBy actionWithDuration:3 position:ccpMult(direction, 700)];
        [actionSprite runAction:moveBy];
        actionSprite.backward = YES;
        actionSprite.forward = actionSprite.up = actionSprite.down = NO;
        actionSprite.reflectingCount ++;
        //reset AOE count
        actionSprite.laserPenetrationCheck = 0;
    }
    if (actionSprite.position.y >= actionSprite.layer.winSize.height && !actionSprite.up) {
        actionSprite.bulletAngle =  360 - actionSprite.bulletAngle;
        actionSprite.rotation = -actionSprite.bulletAngle;
        CGPoint direction = ccpForAngle(CC_DEGREES_TO_RADIANS(actionSprite.bulletAngle));
        CCMoveBy *moveBy= [CCMoveBy actionWithDuration:3 position:ccpMult(direction, 700)];
        [actionSprite runAction:moveBy];
        actionSprite.up = YES;
        actionSprite.forward = actionSprite.backward = actionSprite.down = NO;
        actionSprite.reflectingCount ++;
        //reset AOE count
        actionSprite.laserPenetrationCheck = 0;
    }
    if (actionSprite.position.y <= 0 && ! actionSprite.down) {
        actionSprite.bulletAngle = 360 -actionSprite.bulletAngle;
        actionSprite.rotation = -actionSprite.bulletAngle;
        CGPoint direction = ccpForAngle(CC_DEGREES_TO_RADIANS(actionSprite.bulletAngle));
        CCMoveBy *moveBy= [CCMoveBy actionWithDuration:3 position:ccpMult(direction, 700)];
        [actionSprite runAction:moveBy];
        actionSprite.down = YES;
        actionSprite.forward = actionSprite.backward = actionSprite.up = NO;
        actionSprite.reflectingCount ++;
        //reset AOE count
        actionSprite.laserPenetrationCheck = 0;
    }
    
    if (actionSprite.reflectingCount >=5)
    {
        [actionSprite.layer removeGameObject:actionSprite Team:YES];
    }
}


@end
