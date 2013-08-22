//
//  Grenade.m
//  AnimalRescue
//
//  Created by iMac on 4/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Grenade.h"


@implementation Grenade
{
    ActionSprite *_sprite;
    ActionSprite *_actionSprite;
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    _sprite = [[HeroBabe alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:_sprite];
    _sprite.position = actionSprite.position;
    _sprite.isRanged = YES;
    _sprite.attackRate = 100;
    //not visible
    _sprite.visible = NO;
    //asssign bullet type and class
    _sprite.bulletClass = actionSprite.bulletClass;
    _sprite.bulletActionType = kbulletActionGrenade;
    //removing temporary sprites
    CCDelayTime *spriteDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *removeObject = [CCCallBlock actionWithBlock:^{
        [actionSprite.layer removeTemporaryObject:_sprite];
    }];
    [actionSprite runAction:[CCSequence actions:spriteDuration, removeObject, nil]];
}

@end
