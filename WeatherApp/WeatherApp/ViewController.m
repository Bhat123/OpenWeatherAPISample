//
//  ViewController.m
//  WeatherApp
//
//  Created by Chandrika Bhat on 15/11/16.
//  Copyright © 2016 Weather. All rights reserved.
//

#import "ViewController.h"
#import "APIRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
    _weatherTableView.backgroundColor = [UIColor clearColor];

    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)performWeatherAction:(id)sender {
    [self loadUI];
    [self.view endEditing:true];
}

-(void)loadUI
{
    APIRequest *request = [[APIRequest alloc] init];
    [request weatherReportForLocation:_locationTF.text completion:^(BOOL success, NSData *response, NSError *error) {
        if (success) {
            
            NSError *e = nil;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &e];
            if (!jsonArray) {
                NSLog(@"Error parsing JSON: %@", e);
            } else {
                weatherReportArray = [[NSMutableArray alloc] init];
                weatherReportArray = jsonArray[@"list"];
                [_weatherTableView reloadData];
            }
        }
        else {
            
        }
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [weatherReportArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
        {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:MyIdentifier];
        }

    cell.textLabel.text = [self unixDateToString:[weatherReportArray objectAtIndex:indexPath.row][@"dt"]];
    NSDictionary *dict = [weatherReportArray objectAtIndex:indexPath.row][@"temp"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Day %@, Min %@, Max %@, Night %@, Evening %@, Morning %@", dict[@"day"], dict[@"min"], dict[@"max"], dict[@"night"], dict[@"eve"], dict[@"morn"]];
    return cell;
}
-(NSString*)unixDateToString:(id)interval
{
    NSTimeInterval timeInterval=[interval doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString=[dateformatter stringFromDate:date];
    return dateString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
