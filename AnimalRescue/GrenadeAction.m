//
//  GrenadeAction.m
//  AnimalRescue
//
//  Created by iMac on 4/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GrenadeAction.h"


@implementation GrenadeAction
{
    ActionSprite *_actionSprite;
    CGPoint _direction;
}

-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum
{
    _actionSprite = actionSprite;
    CCLOG(@"caonidaye");
        ActionSprite *bullet = [actionSprite.layer createBulletClass:actionSprite.bulletClass ForTeam:actionSprite.isAlly withActor:NO actionSprite:actionSprite];
        bullet.alive = NO;
        direction = ccp(1, 0);
        
        bullet.rotation = -1 * CC_RADIANS_TO_DEGREES(ccpToAngle(direction));
        
        CCJumpBy *jump1 = [CCJumpBy actionWithDuration:1.2 position:ccpMult(bullet.layer.direction1, 150) height:20 jumps:1];
        [bullet runAction:[CCSequence actions:jump1,[CCCallBlock actionWithBlock:^{[self explosion:bullet];}], nil]];
}

-(void)explosion:(ActionSprite *)sprite
{
    for (int i=0; i<12 ; i++)
    {
        ActionSprite *bullet = [sprite.layer createBulletClass:_actionSprite.bulletClass ForTeam:sprite.isAlly withActor:NO actionSprite:sprite];
       _direction = ccpForAngle(CC_DEGREES_TO_RADIANS(30 * i));
        
        bullet.rotation =  -1 * CC_RADIANS_TO_DEGREES(ccpToAngle(_direction));
        CCMoveBy *moveBy = [CCMoveBy actionWithDuration:0.3 position:ccpMult(_direction, 70)];
        
        [bullet runAction:[CCSequence actions: moveBy, [CCCallBlock actionWithBlock:^{[bullet.layer removeGameObject:bullet Team:bullet.isAlly];}], nil]];
    }
    [sprite.layer removeGameObject:sprite Team:sprite.isAlly];
}

@end
