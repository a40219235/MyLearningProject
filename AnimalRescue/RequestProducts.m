//
//  RequestProducts.m
//  AnimalRescue
//
//  Created by iMac on 5/5/13.
//
//

#import "RequestProducts.h"
#import <StoreKit/StoreKit.h>
#import "IAPProduct.h"

@interface RequestProducts () <SKProductsRequestDelegate>

@end

@implementation RequestProducts
{
    SKProductsRequest *_productsRequest;
    RequestProductsCompletionHandler _completionHandler;
    
    NSMutableDictionary *_productsMuDic;
}

+(RequestProducts *)sharedRequestProductsInstance
{
    static dispatch_once_t once;
    static RequestProducts *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init
{
    if ((self = [super init]))
    {
        //init Multable Dictionary
        IAPProduct *boomerang = [[IAPProduct alloc] initWithProductIdentifier:@"com.shanefu.www.boomskill"];
        IAPProduct *bulletIncrease1 = [[IAPProduct alloc] initWithProductIdentifier:@"com.shanefu.www.bullet"];
        _productsMuDic = [@{boomerang.productIdentifier:boomerang, bulletIncrease1.productIdentifier:bulletIncrease1} mutableCopy];
    }
    return self;
}

-(void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler
{
    //for some reason, I need to init _completionHandler here
    _completionHandler = [completionHandler copy];
    
    NSMutableSet *productIdentifiersMuSet = [NSMutableSet setWithCapacity:_productsMuDic.count];
    for (IAPProduct *product in _productsMuDic.allValues)
    {
        //initially mark all the product unavailable and create a set of productIdentifier
        product.availableForPurchase = NO;
        [productIdentifiersMuSet addObject:product.productIdentifier];
    }
    
    //init SKProductsRequest require a set of ProductIdentifiers and sent delegate to self
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiersMuSet];
    _productsRequest.delegate = self;
    [_productsRequest start];
    //start calling productsRequest
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *skProductsArray = response.products;
    for (SKProduct *skproduct in skProductsArray)
    {
        IAPProduct *iapProduct = _productsMuDic[skproduct.productIdentifier];
        iapProduct.skProduct = skproduct;
        iapProduct.availableForPurchase = YES;
    }
    //this step is unnesscerry but good for debugging purpose
    for (NSString *invalidProductIdentifier in response.invalidProductIdentifiers)
    {
        IAPProduct *product = _productsMuDic[invalidProductIdentifier];
        product.availableForPurchase = NO;
    }
    
    NSMutableArray *availableProducts = [NSMutableArray array];
    for (IAPProduct *iapProduct in _productsMuDic.allValues)
    {
        if (iapProduct.availableForPurchase)
        {
            [availableProducts addObject:iapProduct];
        }
    }
    
    _completionHandler(YES, availableProducts);
    _completionHandler = nil;
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    CCLOG(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(FALSE, nil);
    _completionHandler = nil;
}

@end

