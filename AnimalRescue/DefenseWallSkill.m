//
//  DefenseWallSkill.m
//  AnimalRescue
//
//  Created by iMac on 4/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "DefenseWallSkill.h"


@implementation DefenseWallSkill1
{
    ActionSprite *_wall;
}

static DefenseWallSkill1 *sharedDefenseWall1SkillLayer;

+(DefenseWallSkill1*)sharedDefenseWallSkill1Layer
{
    return sharedDefenseWall1SkillLayer;
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    //retain the layer
    sharedDefenseWall1SkillLayer = self;
    

    _wall = [[DefenseWall alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:_wall];
    _wall.position = actionSprite.position;
    _wall.walkAction = _wall.idleAction;
    [actionSprite.layer.heroArray addObject:_wall];

    //removing temporary sprites
    CCDelayTime *spriteDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *removeObject = [CCCallBlock actionWithBlock:^{
        [actionSprite.layer removeTemporaryObject:_wall];
    }];
    [actionSprite runAction:[CCSequence actions:spriteDuration, removeObject, nil]];
}

-(void)updatePosition:(ActionSprite *)actionSprite
{
    _wall.position = actionSprite.position;
}

@end

@implementation DefenseWallSkill2
{
    ActionSprite *_wall;
}

static DefenseWallSkill2 *sharedDefenseWall2SkillLayer;

+(DefenseWallSkill2*)sharedDefenseWallSkill2Layer
{
    return sharedDefenseWall2SkillLayer;
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    //retain the layer
    sharedDefenseWall2SkillLayer = self;
    
    _wall = [[DefenseWall alloc] initWithTeam:YES layer:actionSprite.layer];
    [actionSprite.layer.batchNode addChild:_wall];
    _wall.position = actionSprite.position;
    _wall.walkAction = _wall.idleAction;
    [actionSprite.layer.heroArray addObject:_wall];
    
    //removing temporary sprites
    CCDelayTime *spriteDuration = [CCDelayTime actionWithDuration:5];
    CCCallBlock *removeObject = [CCCallBlock actionWithBlock:^{
        [actionSprite.layer removeTemporaryObject:_wall];
    }];
    [actionSprite runAction:[CCSequence actions:spriteDuration, removeObject, nil]];
}

-(void)updatePosition:(ActionSprite *)actionSprite
{
    _wall.position = actionSprite.position;
}

@end
