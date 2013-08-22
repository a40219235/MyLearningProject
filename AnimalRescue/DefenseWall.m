//
//  DefenseWall.m
//  AnimalRescue
//
//  Created by iMac on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "DefenseWall.h"


@implementation DefenseWall

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer
{
    if ((self = [super initWithSpriteFrameName:@"castle1_def.png" layer:layer]))
    {
        //hurt Animation
     //   self.hurtAction = [CCSequence actions:[CCBlink actionWithDuration:0.005 blinks:1], [CCCallBlock actionWithBlock:^{self.visible = YES; self.actionState = kActionStateIdle;}], nil];
        self.hurtAction = [CCSequence actions:[CCTintTo actionWithDuration:0.1 red:255 green:0 blue:0], [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255], nil];
        
        //knocked Out Animation
        self.knockedOutAction = [CCFadeOut actionWithDuration:1];
        
        //walk Animation
        self.walkAction = [CCFadeOut actionWithDuration:1];
        
        self.isAlly = isAlly;
        self.isMelee = YES;
        self.alive = YES;
        self.health = 50;
        self.isDefenseWall = YES;
        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-29, -30) size:CGSizeMake(29 * 2, 30 * 2)];
    }
    return self;
}

@end
