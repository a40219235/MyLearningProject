//
//  Level3.m
//  AnimalRescue
//
//  Created by iMac on 4/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Level3.h"
#import "Robot.h"
#import "MonsterEnemy.h"


@implementation Level3
{
    InGameLayer *_ingameLayer;
    CCLabelTTF *_waveLabel;
    float _reachEndGame;
    BOOL _chanimei;
    
    BOOL _spawn;
}

-(void)executeLevel:(InGameLayer *)ingameLayer
{
    _ingameLayer = ingameLayer;
    _reachEndGame = CACurrentMediaTime() + 45;
    
    _waveLabel = [CCLabelTTF labelWithString:@"hfdgf" fontName:@"Marker Felt" fontSize:64];
    _waveLabel.position = ccp(ingameLayer.winSize.width/2, ingameLayer.winSize.height/2);
    [ingameLayer addChild:_waveLabel];
    _waveLabel.opacity = 0;
    
    [self performSelector:@selector(preWave) withObject:self afterDelay:3.5];
}

-(void)preWave
{
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:0.5];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:8];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:16];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:0.5];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:8];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:16];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:0.5];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:8];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:16];
    [self performSelector:@selector(showLabel) withObject:self afterDelay:28];
    for (int i = 0; i< 12; i++)
    {
        [self performSelector:@selector(spawnRobot) withObject:self afterDelay:32 + 0.36 * i];
    }
[self performSelector:@selector(spawnMonster) withObject:self afterDelay:32];
}

-(void)spawnRobot
{
    int randomNumber = CCRANDOM_0_1() *5;
    [_ingameLayer spwanwithclass:[Robot class] isAlly:NO columnPosition:11 rowPosition:randomNumber additionX:0 walkActionDelay:1.0/12.0 velocity:20];
}

-(void)spawnMonster
{
    [_ingameLayer spwanwithclass:[MonsterEnemy class] isAlly:NO columnPosition:11 rowPosition:0 additionX:0 walkActionDelay:0 velocity:0];
    [_ingameLayer spwanwithclass:[MonsterEnemy class] isAlly:NO columnPosition:11 rowPosition:3 additionX:0 walkActionDelay:0 velocity:0];
}

-(void)showLabel
{
    [_waveLabel setString:[NSString stringWithFormat:@"Final Wave"]];
    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:1.5 opacity:255];
    CCDelayTime *delayTime = [CCDelayTime actionWithDuration:1];
    CCScaleTo *scaleTo = [CCScaleTo actionWithDuration:.7 scale:0];
    CCRotateTo *rotateTo = [CCRotateTo actionWithDuration:.7 angle:1800];
    CCSpawn *scaleANDrotate = [CCSpawn actions:scaleTo, rotateTo, nil];
    [_waveLabel runAction:[CCSequence actions:fadeTo, delayTime, scaleANDrotate, nil]];
}

-(void)update:(ccTime)dt
{
    if (CACurrentMediaTime() > _reachEndGame)
    {
        [self gameOver];
    }
}

-(void)gameOver
{
    if (_ingameLayer.enemyArray.count == 0 && !_chanimei)
    {
        [_ingameLayer endGameWin];
        _chanimei = YES;
    }
}

@end
