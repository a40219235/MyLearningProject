//
//  MachineGunAction.m
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MachineGunAction.h"


@implementation MachineGunAction
{
    ActionSprite *_actionSprite;
    CGPoint _direction;
}

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    _actionSprite = actionSprite;
    _direction = direction;
    for (int i= 0; i< bulletNum; i++)
    {
        CCDelayTime *delayMachineGun = [CCDelayTime actionWithDuration:0.06*i];
        CCCallBlock *createBullet = [CCCallBlock actionWithBlock:^{
            [self createBullet];
        }];
        CCSequence *machineGunshoot = [CCSequence actions:delayMachineGun, createBullet, nil];
        [actionSprite runAction:machineGunshoot];
    }
}

-(void)createBullet
{
    ActionSprite *bullet = [_actionSprite.layer createBulletClass:_actionSprite.bulletClass ForTeam:_actionSprite.isAlly withActor:NO actionSprite:_actionSprite];
    
    bullet.rotation = -1 * CC_RADIANS_TO_DEGREES(ccpToAngle(_direction));
    
    if ([_actionSprite isKindOfClass:[MidiumMonster class]])
    {
        [bullet runAction:[CCSequence actions: [CCMoveBy actionWithDuration:4 position:ccpMult(_direction, 500)], [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
        return;
    }
    
    _direction = ccp(1,0);
    [bullet runAction:[CCSequence actions:[CCMoveBy actionWithDuration:1.5 position:ccpMult(_direction, 500)], [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
}

@end
