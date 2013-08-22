//
//  CCAnimationHelper.m
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CCAnimationHelper.h"


@implementation CCAnimation (Helper)

+(CCAnimation*) animationWithFrame:(NSString*)frameName frameCount:(int)frameCount delay:(float)delay
{
	// load the ship's animation frames as textures and create a sprite frame
	CCArray *animationFrames = [CCArray arrayWithCapacity:frameCount];
	for (int i = 0; i < frameCount; i++)
	{
        CCSpriteFrame *frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@%02d.png",frameName ,i]];
		[animationFrames addObject:frame];
	}
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:[animationFrames getNSArray] delay:delay];
	
	// return an animation object from all the sprite animation frames
	return animation;
}

@end
