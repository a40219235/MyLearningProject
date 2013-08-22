//
//  RequestProducts.h
//  AnimalRescue
//
//  Created by iMac on 5/5/13.
//
//

#import <Foundation/Foundation.h>
#import "IAPProduct.h"

typedef void(^RequestProductsCompletionHandler)(BOOL success, NSArray *productsArray);

@interface RequestProducts : NSObject

+(RequestProducts *)sharedRequestProductsInstance;

-(void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end

