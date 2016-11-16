//
//  ViewController.h
//  WeatherApp
//
//  Created by Chandrika Bhat on 15/11/16.
//  Copyright © 2016 Weather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITabBarDelegate,UITableViewDataSource>
{
    NSMutableArray * weatherReportArray;
}
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;
@property (weak, nonatomic) IBOutlet UIButton *getWeatherReportButton;

- (IBAction)performWeatherAction:(id)sender;


@end

