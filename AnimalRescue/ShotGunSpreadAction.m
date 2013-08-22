//
//  ShotGunSpreadAction.m
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ShotGunSpreadAction.h"


@implementation ShotGunSpreadAction
{
    ActionSprite *_actionSprite;
    CGPoint _direction;
}

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    _actionSprite = actionSprite;
    _direction = direction;
    for (int j = 0; j < bulletNum; j++)
    {
        [self performSelector:@selector(createBullet) withObject:self afterDelay:0.15 * j];
    }
}

-(void)createBullet
{
    for (int i=0; i<3 ; i++)
    {
        ActionSprite *bullet = [_actionSprite.layer createBulletClass:_actionSprite.bulletClass ForTeam:_actionSprite.isAlly withActor:NO actionSprite:_actionSprite];
        if (i == 0) _direction = bullet.layer.direction1;
        if (i == 1) _direction = bullet.layer.direction2;
        if (i == 2) _direction = bullet.layer.direction3;
        
        bullet.rotation = -1 * CC_RADIANS_TO_DEGREES(ccpToAngle(_direction));
        
        CCMoveBy *moveForward = [CCMoveBy actionWithDuration:1.4 position:ccpMult(_direction, 225)];
        [bullet runAction:[CCSequence actions: moveForward, [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
    }
    
}




@end
