//
//  HeroBabe.m
//  AnimalRescue
//
//  Created by iMac on 4/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HeroBabe.h"


@implementation HeroBabe

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer
{
    if ((self = [super initWithSpriteFrameName:@"zap1.png" layer:layer]))
    {
        //idle Animation
        self.idleAction = [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255];
        
        //attack Animation
        self.attackAction = [CCSequence actions:[CCTintTo actionWithDuration:0.1 red:0 green:255 blue:0], [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255], nil];
        
        //hurt Animation
        self.hurtAction = [CCSequence actions:[CCTintTo actionWithDuration:0.1 red:255 green:0 blue:0], [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255], nil];
        
        //knocked Out Animation
        self.knockedOutAction = [CCFadeOut actionWithDuration:1];
        
        self.isAlly = isAlly;
        self.alive = YES;
        
        self.health = 100;
        self.attackDamage = 10;
        self.attackRate = 2.0;
        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-15, -10) size:CGSizeMake(30, 20)];
    }
    return self;
}

@end
