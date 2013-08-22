//
//  ShotGunAction.m
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ShotGunAction.h"


@implementation ShotGunAction

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    for (int i = 0; i < bulletNum; i++)
    {
        ActionSprite *bullet = [actionSprite.layer createBulletClass:actionSprite.bulletClass ForTeam:actionSprite.isAlly withActor:NO actionSprite:actionSprite];
        
        direction = ccp(1,0);
        bullet.rotation = -1 * CC_RADIANS_TO_DEGREES(ccpToAngle(direction));
        
        [bullet runAction:[CCSequence actions:[CCMoveBy actionWithDuration:1 + i*0.1 position:ccpMult(direction, 500)], [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
    }
}

@end
