//
//  InitMenuManager.m
//  AnimalRescue
//
//  Created by iMac on 4/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "InitMenuManager.h"


@implementation InitMenuManager
{
    CCProgressTimer *_timer1;
}

-(CCProgressTimer *)TimerSelector:(int)timerSelector
{
    CCProgressTimer *timer;
    switch (timerSelector)
    {
        case 0:
            timer = [self executeTimerInit];
            timer.chargingRate = 10;
            break;
            
        default:
            break;
    }
    return timer;
}

-(CCMenuItemSprite *)MenuSelector:(int)menuSelector ActionSprite:(ActionSprite *)actionSprite
{
    CCMenuItemSprite *menuSprite;
    switch (menuSelector)
    {
        case 1:
            menuSprite = [self executeMenu1Init:actionSprite];
            break;
        case 2:
            menuSprite = [self executeMenu2Init:actionSprite];
            break;
        case 3:
            menuSprite = [self executeMenu3Init:actionSprite];
            break;
        case 4:
            menuSprite = [self executeMenu4Init:actionSprite];
            break;
        case 5:
            menuSprite = [self executeMenu5Init:actionSprite];
            break;
        case 6:
            menuSprite = [self executeMenu6Init:actionSprite];
            break;
        case 7:
            menuSprite = [self executeMenu7Init:actionSprite];
            break;
        case 8:
            menuSprite = [self executeMenu8Init:actionSprite];
            break;
        case 9:
            menuSprite = [self executeMenu9Init:actionSprite];
            break;
        case 10:
            menuSprite = [self executeMenu10Init:actionSprite];
            break;
        case 11:
            menuSprite = [self executeMenu11Init:actionSprite];
            break;
        case 12:
            menuSprite = [self executeMenu12Init:actionSprite];
            break;
            
            
        default: CCLOG(@"there is no case 0 on menu Selector");
            break;
    }
    return menuSprite;
}

-(CCProgressTimer *)executeTimerInit
{
    _timer1 = [CCProgressTimer progressWithSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"]];
    _timer1.percentage = 100;
    return _timer1;
}

-(CCMenuItemSprite *)executeMenu1Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite1 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton1Tapped:)];
    menuSprite1.position = ccp(actionSprite.position.x - 35, actionSprite.position.y + 49);
    return menuSprite1;
}

-(CCMenuItemSprite *)executeMenu2Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite2 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton2Tapped:)];
    menuSprite2.position = ccp(actionSprite.position.x - 36, actionSprite.position.y);
    return menuSprite2;
}

-(CCMenuItemSprite *)executeMenu3Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite3 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton3Tapped:)];
    menuSprite3.position = ccp(actionSprite.position.x - 35, actionSprite.position.y - 49);
    return menuSprite3;
}

-(CCMenuItemSprite *)executeMenu4Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite4 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton4Tapped:)];
    menuSprite4.position = ccp(actionSprite.position.x - 84, actionSprite.position.y +24);
    return menuSprite4;
}

-(CCMenuItemSprite *)executeMenu5Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite5 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton5Tapped:)];
    menuSprite5.position = ccp(actionSprite.position.x - 84, actionSprite.position.y - 24);
    return menuSprite5;
}

-(CCMenuItemSprite *)executeMenu6Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite6 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton6Tapped:)];
    menuSprite6.position = ccp(actionSprite.position.x - 131, actionSprite.position.y);
    return menuSprite6;
}

-(CCMenuItemSprite *)executeMenu7Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite1 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton7Tapped:)];
    menuSprite1.position = ccp(actionSprite.position.x - 35, actionSprite.position.y + 49);
    return menuSprite1;
}

-(CCMenuItemSprite *)executeMenu8Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite2 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton8Tapped:)];
    menuSprite2.position = ccp(actionSprite.position.x - 36, actionSprite.position.y);
    return menuSprite2;
}

-(CCMenuItemSprite *)executeMenu9Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite3 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton9Tapped:)];
    menuSprite3.position = ccp(actionSprite.position.x - 35, actionSprite.position.y - 49);
    return menuSprite3;
}

-(CCMenuItemSprite *)executeMenu10Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite4 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton10Tapped:)];
    menuSprite4.position = ccp(actionSprite.position.x - 84, actionSprite.position.y +24);
    return menuSprite4;
}

-(CCMenuItemSprite *)executeMenu11Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite5 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton11Tapped:)];
    menuSprite5.position = ccp(actionSprite.position.x - 84, actionSprite.position.y - 24);
    return menuSprite5;
}

-(CCMenuItemSprite *)executeMenu12Init:(ActionSprite *)actionSprite
{
    CCMenuItemSprite* menuSprite6 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton12Tapped:)];
    menuSprite6.position = ccp(actionSprite.position.x - 131, actionSprite.position.y);
    return menuSprite6;
}


//-(CCMenuItemSprite *)executeMenu2Init:(ActionSprite *)actionSprite
//{
//    CCMenuItemSprite* menuSprite2 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton2Tapped:)];
//    menuSprite2.position = ccp(actionSprite.position.x - 84, actionSprite.position.y + 24);
//    return menuSprite2;
//}
//
//-(CCMenuItemSprite *)executeMenu3Init:(ActionSprite *)actionSprite
//{
//    CCMenuItemSprite* menuSprite3 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton3Tapped:)];
//    menuSprite3.position = ccp(actionSprite.position.x - 84, actionSprite.position.y - 24);
//    return menuSprite3;
//}
//
//-(CCMenuItemSprite *)executeMenu4Init:(ActionSprite *)actionSprite
//{
//    CCMenuItemSprite* menuSprite4 = [CCMenuItemSprite itemWithNormalSprite:_timer1 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"] target:actionSprite.layer selector:@selector(PlayerButton4Tapped:)];
//    menuSprite4.position = ccp(actionSprite.position.x - 35, actionSprite.position.y - 49);
//    return menuSprite4;
//}
@end
