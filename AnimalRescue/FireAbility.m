//
//  FireAbility.m
//  AnimalRescue
//
//  Created by iMac on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FireAbility.h"


@implementation FireAbility
{
    ActionSprite *_actionSprite;
}
-(void)executeSkill:(ActionSprite *)actionSprite
{
    _actionSprite = actionSprite;
    actionSprite.fireAbilityEnable = YES;
    
    //reset ability
    CCDelayTime *abilityDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *resetAbility = [CCCallBlock actionWithBlock:^{
        [self resetFireAbility];
    }];
    [actionSprite runAction:[CCSequence actions:abilityDuration, resetAbility, nil]];
}

-(void)resetFireAbility
{
    _actionSprite.fireAbilityEnable = NO;
}
@end
