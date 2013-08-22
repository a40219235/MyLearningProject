//
//  AppDelegate.h
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

typedef enum _SkillType
{
    kSkillNone = 0,
    kSkillTwoCloneShooter1,
    kSkillTwoCloneShooter2,
    kSkillSideSpreading1,
    kSkillSideSpreading2,
    kSkillDefenseWall1,
    kSkillDefenseWall2,
    kSkillFireAbility,
    kSkillFreezingAbility,
    kSkillGrenade,
    kSkillReflectingBullet,
    kSkillBoomerang,
    kSkillBoomerang2,
    KSkillBoomerangUltimate,
} SkillType;

enum
{
    kButtonNone = 0,
    kbutton1,
    kbutton2,
    kbutton3,
    kbutton4,
    kbutton5,
    kbutton6,
    kbutton7,
    kbutton8,
    kbutton9,
    kbutton10,
    kbutton11,
    kbutton12,
    kMachineGunBullets
};

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

+ (AppController *)sharedAppController;

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

//skillEnum
@property (nonatomic, assign) SkillType skillType;

@end
