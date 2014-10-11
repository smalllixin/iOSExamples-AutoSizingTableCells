//
//  AutoSizingController.m
//  AutoSizingTableCells
//
//  Created by Brian Mancini on 7/26/14.
//  Copyright (c) 2014 RedTurn. All rights reserved.
//

#import "AutoSizingController.h"
#import "AutoSizeCell.h"
#import <PureLayout.h>
@interface AutoSizingController()<UITableViewDataSource, UITableViewDelegate>
@end
@implementation AutoSizingController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [UITableView newAutoLayoutView];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [tableView registerClass:[AutoSizeCell class] forCellReuseIdentifier:@"plerp"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

- (NSString *)getText:(NSInteger)row
{
    switch (row%4) {
        case 0:
            return @"This is some long text that should wrap. It is multiple long sentences that may or may not have spelling and grammatical errors. Yep it should wrap quite nicely and serve as a nice example!";
        case 1:
            return @"Run pod install from Terminal, then open your app's .xcworkspace file to launch Xcode.#import PureLayout.h wherever you want to use the API. (Hint: add this import to your prefix header (.pch) file so that the API is automatically available everywhere!)";
        case 2:
            return @"十大最悲剧的自拍时刻-看你中了几个blahsd 中国好声音，好凉茶好凉茶哦！十大最悲剧的自拍时刻-看你中了几个blahsd 中国好声音，好凉茶好凉茶哦！";
        default:
            return @"If the view is stuck, follow the views that are below it and make sure one of them doesn't have a top space to superview constraint. Then just make sure your number of lines option for the label is set to 0 and it should take care of the rest.";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a reusable cell
//    AutoSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plerp"];
//    if(!cell) {
//        cell = [[AutoSizeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"plerp"];
//    }
    AutoSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plerp" forIndexPath:indexPath];
    
    // Configure the cell for this indexPath
    cell.titleLabel.text = [self getText:indexPath.row];
    cell.noLabel.text = [NSString stringWithFormat:@"%d 中国好声音，好凉茶好凉茶哦！十大最悲剧的自拍时刻-",indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoSizeCell *cell = [[AutoSizeCell alloc] init];
    cell.titleLabel.text = [self getText:indexPath.row];
    cell.noLabel.text = [NSString stringWithFormat:@"%d 中国好声音，好凉茶好凉茶哦！十大最悲剧的自拍时刻-",indexPath.row];
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}

@end
