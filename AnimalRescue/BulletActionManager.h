//
//  BulletActionManager.h
//  AnimalRescue
//
//  Created by iMac on 4/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"
#import "InGameLayer.h"

@interface BulletActionManager : CCNode {
    
}

-(void)enter:(ActionSprite *)actionSprite;
-(void)execute:(ActionSprite *)actionSprite direction:(CGPoint)direction bulletNum:(int)bulletNum;
-(void)exit:(ActionSprite *)actionSprite;

-(void)updateBouncing:(ActionSprite *)actionSprite;

@end
