//
//  FireElement.m
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FireElement.h"


@implementation FireElement

-(void)execute:(ActionSprite *)actionSprite
{
    actionSprite.particleSun = [CCParticleSun node];
    actionSprite.particleSun.totalParticles =15;
    actionSprite.particleSun.life = 0.5;
    actionSprite.particleSun.lifeVar =0;
    actionSprite.particleSun.emissionRate = 30;
//    actionSprite.particleSun.autoRemoveOnFinish = YES;
    actionSprite.particleSun.position = actionSprite.position;
    [actionSprite.layer addChild:actionSprite.particleSun];
}


@end
