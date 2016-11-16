//
//  APIRequest.m
//  WeatherApp
//
//  Created by Chandrika Bhat on 16/11/16.
//  Copyright © 2016 Weather. All rights reserved.
//

#import "APIRequest.h"

@implementation APIRequest

-(void)weatherReportForLocation:(NSString*)searchString completion:(void (^)(BOOL success, NSData *response, NSError *error))completionBlock
{
    
        //API: http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=6e70f19a31609f65f8a5dc6b77e666d2
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&units=imperial&APPID=6e70f19a31609f65f8a5dc6b77e666d2",searchString]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                               {
                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                               NSLog(@"Data = %@",text);
                                                               if (completionBlock != nil)
                                                                   completionBlock(true,data,nil);
                                                               }
                                                           else{
                                                               completionBlock(false,data,error);
                                                           }
                                                       }];
    [dataTask resume];
    
    
}


@end
