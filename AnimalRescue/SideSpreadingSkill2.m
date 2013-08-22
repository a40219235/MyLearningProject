//
//  SideSpreadingSkill2.m
//  AnimalRescue
//
//  Created by iMac on 4/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SideSpreadingSkill2.h"


@implementation SideSpreadingSkill2
{
    ActionSprite *_sprite;
}

static SideSpreadingSkill2 *sharedSideSpreadingSkill2Layer;

+(SideSpreadingSkill2*)sharedSideSpreadingSkill2Layer
{
    return sharedSideSpreadingSkill2Layer;
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    sharedSideSpreadingSkill2Layer = self;
    
    _sprite = [[HeroBabe alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:_sprite];
    _sprite.position = actionSprite.position;
    _sprite.isRanged = YES;
    _sprite.attackRate = 100;
    //not visible
    _sprite.visible = NO;
    //asssign bullet type and class
    _sprite.bulletClass = actionSprite.bulletClass;
    _sprite.bulletActionType = kbulletActionSideSpread;
    //assign ability and effect
    _sprite.freezingAbilityEnable = actionSprite.freezingAbilityEnable;
    _sprite.fireAbilityEnable = actionSprite.fireAbilityEnable;
    
    //removing temporary sprites
    CCDelayTime *spriteDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *removeObject = [CCCallBlock actionWithBlock:^{
        [actionSprite.layer removeTemporaryObject:_sprite];
    }];
    [actionSprite runAction:[CCSequence actions:spriteDuration, removeObject, nil]];
}

-(void)updatePosition:(ActionSprite *)actionSprite
{
    _sprite.position = actionSprite.position;
}

@end
