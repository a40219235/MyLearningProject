//
//  MonsterEnemy.h
//  AnimalRescue
//
//  Created by iMac on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "ActionSprite.h"
@interface MonsterEnemy : ActionSprite {
    
}

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer;
@end
