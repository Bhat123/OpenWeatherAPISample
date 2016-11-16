//
//  APIRequest.h
//  WeatherApp
//
//  Created by Chandrika Bhat on 16/11/16.
//  Copyright © 2016 Weather. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequest : NSObject
{
    
}
-(void)weatherReportForLocation:(NSString*)searchString completion:(void (^)(BOOL success, NSData *response, NSError *error))completionBlock;
@end
