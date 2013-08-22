//
//  GameLevelManager.h
//  AnimalRescue
//
//  Created by iMac on 4/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"
#import "InGameLayer.h"
#import "Robot.h"
#import "MonsterEnemy.h"

@interface GameLevelManager : CCNode {
    
}

-(id)initWithLevel:(int)level IngameLayer:(InGameLayer*)ingameLayer;

-(void)enterLevel:(int)level IngameLayer:(InGameLayer *)ingameLayer;
-(void)executeLevel:(InGameLayer *)ingameLayer;
-(void)exitLevel:(InGameLayer *)ingameLayer;

-(void)update:(ccTime)dt;

@end
