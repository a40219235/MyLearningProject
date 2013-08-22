//
//  FreezingAbility.m
//  AnimalRescue
//
//  Created by iMac on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FreezingAbility.h"


@implementation FreezingAbility
{
    ActionSprite *_actionSprite;
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    _actionSprite = actionSprite;
    actionSprite.freezingAbilityEnable = YES;
    
    //reset ability
    CCDelayTime *abilityDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *resetAbility = [CCCallBlock actionWithBlock:^{
        [self resetFreezingAbility];
    }];
    [actionSprite runAction:[CCSequence actions:abilityDuration, resetAbility, nil]];
}

-(void)resetFreezingAbility
{
    _actionSprite.freezingAbilityEnable = NO;
}
@end
