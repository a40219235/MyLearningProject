//
//  AppStoreList.m
//  AnimalRescue
//
//  Created by iMac on 5/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "AppStoreList.h"
#import "IAPProduct.h"
#import <StoreKit/StoreKit.h>
#import "RequestProducts.h"
#import "PaymentHandler.h"

@interface AppStoreList () <UIAlertViewDelegate>

@end

@implementation AppStoreList
{
    CCMenu *menu_;
    int cellNum;
    CCMenuItemSprite *cell_;
    CCArray *cellArray_;
    
    NSNumberFormatter *_priceFormatter;
}

static AppStoreList *sharedAppStoreListLayer;

+(AppStoreList *)sharedAppStoreListLayer
{
    return sharedAppStoreListLayer;
}

-(id) init
{
    if ((self = [super init]))
    {
        _winSize = [[CCDirector sharedDirector] winSize];
        
        CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
        item2.position = ccp(32, 32);
        CCMenuItemFont *restore = [CCMenuItemFont itemWithString:@"Restore" target:self selector:@selector(Restore:)];
        restore.position = ccp(_winSize.width - 64, _winSize.height - 32);
        menu_ = [CCMenu menuWithItems:item2, restore, nil];
        menu_.position = CGPointZero;
        [self addChild:menu_];
        
        [self initVariables];
    }
    return self;
}

-(void)initVariables
{
    sharedAppStoreListLayer = self;
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    //Get the product
    [[RequestProducts sharedRequestProductsInstance] requestProductsWithCompletionHandler:^(BOOL sucess, NSArray *productsArray)
     {
         if (sucess)
         {
             _productsArray = [[NSArray alloc] initWithArray:productsArray];
             
             // Set up productsDic
             _productsMuDic = [[NSMutableDictionary alloc] init];
             for (IAPProduct *iapProduct in _productsArray)
             {
                 [_productsMuDic setObject:iapProduct forKey:iapProduct.productIdentifier];
             }
         }
         [self listProducts];
     }];
    
    //init var
    cellArray_ = [[CCArray alloc] init];
}

-(void)addCell
{
    cell_ = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"Cell.png"] selectedSprite:nil target:self selector:@selector(CellTapped:)];
    cell_.position = ccp(_winSize.width * 0.5, _winSize.height - 70 * cellNum - 70);
    cell_.originalPosition = cell_.position;
    cell_.scaleX = 1.5;
    cell_.opacity = 130;
    cell_.rowIndex = cellNum;
    [menu_ addChild:cell_];
    
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:15];
    IAPProduct *iapProduct = _productsArray[cellNum];
    [_priceFormatter setLocale:iapProduct.skProduct.priceLocale];
    NSString *priceDisplay = [_priceFormatter stringFromNumber:iapProduct.skProduct.price];
    CCMenuItemFont *priceFont = [CCMenuItemFont itemWithString:priceDisplay];
    if (iapProduct.purchased) {
        [priceFont setString:@"Installed"];
    }
    priceFont.position = ccp(130, 25);
    priceFont.rowIndex = 5;
    [cell_ addChild:priceFont];
    
    [CCMenuItemFont setFontSize:20];
    CCMenuItemFont *iapProductName = [CCMenuItemFont itemWithString:iapProduct.skProduct.localizedTitle];
    iapProductName.position = ccp(35, 25);
    [cell_ addChild:iapProductName];
    
    [cellArray_ addObject:cell_];
    cellNum ++;
}

-(void)refreshingCell
{
    CCMenuItemFont *cellChild;
    for (int i = 0; i < _productsArray.count; i ++)
    {
        IAPProduct *iapProduct = _productsArray[i];
        CCARRAY_FOREACH(cellArray_, cell_)
        {
            if (!cell_.rowIndex == i) continue;
            CCARRAY_FOREACH([cell_ children], cellChild)
            {
                if ([cellChild class] == [CCSprite class]) continue;
                if (cellChild.rowIndex == 5 && iapProduct.purchased && iapProduct.installed) [cellChild setString:@"Installed"];
                if (cellChild.rowIndex == 5 && iapProduct.purchased && !iapProduct.installed) [cellChild setString:@"Free"];
            }
        }
    }
}

-(void)listProducts
{
    for (int i = 0; i < _productsArray.count; i ++)
    {
        [self addCell];
    }
}

-(void)CellTapped:(CCMenuItemSprite *)sender
{
    //buy product
    IAPProduct *iapProduct = _productsArray[sender.rowIndex];
    if (iapProduct.purchaseInProgress) return;
    if (iapProduct.installed && iapProduct.purchased) return;
    [[PaymentHandler sharedPaymentHandlerInstance] buyProduct:iapProduct];
    
    //animate the sender
    sender.position = ccp(sender.originalPosition.x, sender.originalPosition.y - 10);
    [sender runAction:[CCMoveBy actionWithDuration:0.8 position:ccp(0, 10)]];
}

-(void)onBack:(id)sender
{
    [SceneManager goMainMenu];
}

-(void)Restore:(id)sender
{
    NSLog(@"Restore tapped!");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Restore Content" message:@"Would you like to restore any previous purchases?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.delegate = self;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex)
    {
        [[PaymentHandler sharedPaymentHandlerInstance] restoreCompletedTransactions];
    }
}


@end
