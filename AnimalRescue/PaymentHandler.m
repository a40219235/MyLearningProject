//
//  PaymentHandler.m
//  AnimalRescue
//
//  Created by iMac on 5/5/13.
//
//

#import "PaymentHandler.h"
#import <StoreKit/StoreKit.h>
#import "VerificationController.h"
#import "AppStoreList.h"
#import "ProductSender.h"

@interface PaymentHandler () <SKPaymentTransactionObserver>

@end

@implementation PaymentHandler

+(PaymentHandler *)sharedPaymentHandlerInstance
{
    static dispatch_once_t once;
    static PaymentHandler *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init
{
    if ((self = [super init]))
    {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(void)restoreCompletedTransactions
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

-(void)buyProduct:(IAPProduct *)iapProduct
{
    CCLOG(@"iap installed =%d, purchaseInprogress =%d , purchased = %d, availableforpurchase %d", iapProduct.installed, iapProduct.purchaseInProgress, iapProduct.purchased, iapProduct.availableForPurchase);
    NSAssert(iapProduct.allowdToPurchase, @"This product isn't allowd to be purchased");
    NSLog(@"Buying %@", iapProduct.productIdentifier);
    
    iapProduct.purchaseInProgress = YES;
    SKPayment *payment = [SKPayment paymentWithProduct:iapProduct.skProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}

-(void)completeTransaction:(SKPaymentTransaction *)transaction
{
    CCLOG(@"what %@", transaction.payment.productIdentifier);
    CCLOG(@"CompleteTransaction ...");
    [self validateReceiptForTransaction:transaction];
}

-(void)failedTransaction:(SKPaymentTransaction *)transaction
{
    CCLOG(@"FailedTransaction ...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        CCLOG(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    IAPProduct *iapProduct = [AppStoreList sharedAppStoreListLayer].productsMuDic[transaction.payment.productIdentifier];
    iapProduct.purchaseInProgress = NO;
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"restoreTransaction...");
    IAPProduct *iapProduct = [AppStoreList sharedAppStoreListLayer].productsMuDic[transaction.payment.productIdentifier];
    iapProduct.installed = NO;
    iapProduct.purchaseInProgress = NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Boom"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [[AppStoreList sharedAppStoreListLayer] refreshingCell];
}

-(void)validateReceiptForTransaction:(SKPaymentTransaction *)transaction
{
    IAPProduct *iapProduct = [AppStoreList sharedAppStoreListLayer].productsMuDic[transaction.payment.productIdentifier];
    VerificationController *verifier = [VerificationController sharedInstance];
    
    [verifier verifyPurchase:transaction completionHandler:^(BOOL success){
        if (success)
        {
            CCLOG(@"successfully verified receipt!");
            [[ProductSender sharedProductSenderInstance] provideContentForProductIdentifier:iapProduct.productIdentifier];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
        else
        {
            CCLOG(@"Failed to validate receipt.");
            iapProduct.purchaseInProgress = NO;
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
    }];
}

@end
