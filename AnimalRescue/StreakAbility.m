//
//  StreakAbility.m
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StreakAbility.h"


@implementation StreakAbility

-(void)execute:(ActionSprite *)actionSprite
{
    actionSprite.bulletStreak = [CCMotionStreak streakWithFade:0.2 minSeg:1 width:45 color:ccc3(255, 255, 255) textureFilename:@"streak.png"];
    actionSprite.bulletStreak.position = actionSprite.position;
    [actionSprite.layer addChild:actionSprite.bulletStreak];
}

@end
