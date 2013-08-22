//
//  ProductSender.m
//  AnimalRescue
//
//  Created by iMac on 5/5/13.
//
//

#import "ProductSender.h"
#import "MocManager.h"
#import "GameObjectInfo.h"
#import "GameObjectDetails.h"
#import "AppDelegate.h"
#import "AppStoreList.h"
#import "IAPProduct.h"

@implementation ProductSender
{
    MocManager *_mocManager;
}

+(ProductSender *)sharedProductSenderInstance
{
    static dispatch_once_t once;
    static ProductSender *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init
{
    if ((self = [super init]))
    {
        _mocManager = [[MocManager alloc] init];
    }
    return self;
}

-(void)provideContentForProductIdentifier:(NSString *)productIdentifier
{
    IAPProduct *product = [AppStoreList sharedAppStoreListLayer].productsMuDic[productIdentifier];
    
    if ([productIdentifier isEqualToString:@"com.shanefu.www.bullet"])
    {
        int bulletPoints;
        NSArray *fetchedObjectsInfo = [_mocManager fetchGameObjectsInfo];
        for (GameObjectInfo *info in fetchedObjectsInfo)
        {
            if ([info.skill intValue] == kMachineGunBullets)
            {
                bulletPoints = [info.details.points intValue];
                [_mocManager deleteGameObjects:info];
            }
        }
        [_mocManager insertpoints:bulletPoints +1 toSkill:kMachineGunBullets];
    }
    
    if ([productIdentifier isEqualToString:@"com.shanefu.www.boomskill"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Boom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        product.purchased = YES;
        product.installed = YES;
    }
    
    product.purchaseInProgress = NO;
    
    //update List
    [[AppStoreList sharedAppStoreListLayer] refreshingCell];
}

@end
