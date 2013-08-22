//
//  PlayerAnimal.h
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"

@interface Hero : ActionSprite

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer*)layer;

-(id)heroIdleDelay:(float)delay;
-(id)heroAttackDelay:(float)delay;

@end
