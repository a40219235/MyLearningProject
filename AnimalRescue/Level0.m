//
//  Level0.m
//  AnimalRescue
//
//  Created by iMac on 4/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Level0.h"
#import "Robot.h"
#import "MonsterEnemy.h"


@implementation Level0
{
    InGameLayer *_ingameLayer;
    CCLabelTTF *_waveLabel;
    BOOL _finalWaveInProgress;
    float _sequenceTimer;
    BOOL _chanimei;
    
    BOOL _spawn;
}

-(void)executeLevel:(InGameLayer *)ingameLayer
{
    _ingameLayer = ingameLayer;
    _sequenceTimer = 2;
    
    _waveLabel = [CCLabelTTF labelWithString:@"hfdgf" fontName:@"Marker Felt" fontSize:64];
    _waveLabel.position = ccp(ingameLayer.winSize.width/2, ingameLayer.winSize.height/2);
    [ingameLayer addChild:_waveLabel];
    _waveLabel.opacity = 0;
    
    [self performSelector:@selector(preWave) withObject:self afterDelay:_sequenceTimer];
}

-(void)preWave
{
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:_sequenceTimer];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:_sequenceTimer = _sequenceTimer + 4];
    [self performSelector:@selector(spawnRobot) withObject:self afterDelay:_sequenceTimer = _sequenceTimer + 4];
    [self performSelector:@selector(finalWaveLabel) withObject:self afterDelay:_sequenceTimer = _sequenceTimer + 4];
}

-(void)finalWaveLabel
{
    [_waveLabel setString:[NSString stringWithFormat:@"Final Wave"]];
    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:1.5 opacity:255];
    CCDelayTime *delayTime = [CCDelayTime actionWithDuration:1];
    CCScaleTo *scaleTo = [CCScaleTo actionWithDuration:.7 scale:0];
    CCRotateTo *rotateTo = [CCRotateTo actionWithDuration:.7 angle:1800];
    CCSpawn *scaleANDrotate = [CCSpawn actions:scaleTo, rotateTo, nil];
    [_waveLabel runAction:[CCSequence actions:fadeTo, delayTime, scaleANDrotate, nil]];
    
    [self performSelector:@selector(finalWave) withObject:self afterDelay:3];
    
}

-(void)finalWave
{
    for (int i = 0; i< 3; i++)
    {
        [self performSelector:@selector(spawnRobot) withObject:self afterDelay:0.42 * i];
    }
    [self performSelector:@selector(finalWaveInProgress) withObject:self afterDelay:1];
}

-(void)finalWaveInProgress
{
    _finalWaveInProgress = YES;
}


-(void)update:(ccTime)dt
{
    if (_finalWaveInProgress && _ingameLayer.enemyArray.count == 0 && !_chanimei )
    {
        [self performSelector:@selector(gameOver) withObject:self afterDelay:0.5];
        _chanimei = YES;
    }
}

-(void)gameOver
{
        [_ingameLayer endGameWin];
}

-(void)spawnRobot
{
    [_ingameLayer spwanwithclass:[Robot class] isAlly:NO columnPosition:11 rowPosition:2 additionX:0 walkActionDelay:1.0/12.0 velocity:20];
}

@end