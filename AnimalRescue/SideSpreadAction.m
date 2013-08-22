//
//  SideSpreadAction.m
//  AnimalRescue
//
//  Created by iMac on 4/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SideSpreadAction.h"

@implementation SideSpreadAction
{
    ActionSprite *_actionSprite;
    CGPoint _direction;
}

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    _actionSprite = actionSprite;
    _direction = direction;
    for (int i = 0; i< bulletNum; i++)
    {
        [self performSelector:@selector(createBullet) withObject:self afterDelay:0.25 * i];
    }
}

-(void)createBullet
{
    for (int i=0; i<6 ; i++)
    {
        ActionSprite *bullet = [_actionSprite.layer createBulletClass:_actionSprite.bulletClass ForTeam:_actionSprite.isAlly withActor:NO actionSprite:_actionSprite];
        if (i == 0) _direction = bullet.layer.direction4;
        if (i == 1) _direction = bullet.layer.direction5;
        if (i == 2) _direction = bullet.layer.direction6;
        if (i == 3) _direction = bullet.layer.direction7;
        if (i == 4) _direction = ccp(0,1);
        if (i == 5) _direction = ccp(0,-1);
        
        bullet.rotation =  -1 * CC_RADIANS_TO_DEGREES(ccpToAngle(_direction));
        CCMoveBy *moveBy = [CCMoveBy actionWithDuration:0.3 position:ccpMult(_direction, 70)];
        
        [bullet runAction:[CCSequence actions: moveBy, [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
    }
}

@end
