//
//  FreezingElement.m
//  AnimalRescue
//
//  Created by iMac on 4/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FreezingElement.h"


@implementation FreezingElement

-(void)execute:(ActionSprite *)actionSprite
{
    actionSprite.particleMeteor = [CCParticleMeteor node];
    actionSprite.particleMeteor.totalParticles =5;
    actionSprite.particleMeteor.life = 0.2;
    actionSprite.particleMeteor.lifeVar =0;
    actionSprite.particleMeteor.emissionRate = 30;
//    actionSprite.particleMeteor.autoRemoveOnFinish = YES;
    actionSprite.particleMeteor.position = actionSprite.position;
    [actionSprite.layer addChild:actionSprite.particleMeteor];
}

@end
