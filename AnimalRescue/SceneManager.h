//
//  SceneManager.h
//  AnimalRescue
//
//  Created by iMac on 1/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenu.h"
#import "ChapterSelect.h"
#import "OptionMenu.h"
#import "UpgradeLayer.h"
#import "WinningLayer.h"
#import "LosingLayer.h"
#import "AppStoreList.h"

@interface SceneManager : CCNode
{
    
}

+(void) goMainMenu;
+(void) goChapterSelect;
+(void) goOptionMenu;
+(void) goUpgradeLayer;
+(void) goWinningLayer;
+(void) goLosingLayer;
+(void) goAppStoreList;

@end
