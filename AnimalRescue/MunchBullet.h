//
//  MunchBullet.h
//  AnimalRescue
//
//  Created by iMac on 4/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"

@interface MunchBullet : ActionSprite {
    
}
-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer actionSprite:(ActionSprite *)actionSprite;


@end
