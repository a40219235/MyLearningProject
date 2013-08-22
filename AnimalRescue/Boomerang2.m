//
//  Boomerang2.m
//  AnimalRescue
//
//  Created by iMac on 5/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Boomerang2.h"


@implementation Boomerang2
{
    ActionSprite *_sprite;
    ActionSprite *_actionSprite;
}

static Boomerang2 *sharedBoomerang2Layer;

+(Boomerang2 *)sharedBoomerang2Layer
{
    return sharedBoomerang2Layer;
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
    _sprite.bulletClass = [LaserBullet class];
    _sprite.bulletActionType = kbulletActionBoomerang;
    
    //penatrate and effect
    _sprite.streakEffectEnable = YES;
    _sprite.laserPenetrationAbility = YES;
    
    //removing temporary sprites
    CCDelayTime *spriteDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *removeObject = [CCCallBlock actionWithBlock:^{
        [actionSprite.layer removeTemporaryObject:_sprite];
    }];
    [actionSprite runAction:[CCSequence actions:spriteDuration, removeObject, nil]];
}

-(void)updatePosition:(ActionSprite *)actionSprite
{
    _sprite.boomerangBulletInitPosition = actionSprite.position;
}

@end
