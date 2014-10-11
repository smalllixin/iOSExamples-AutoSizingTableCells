//
//  AutoSizeCell.m
//  AutoSizingTableCells
//
//  Created by Brian Mancini on 7/26/14.
//  Copyright (c) 2014 RedTurn. All rights reserved.
//

#import "AutoSizeCell.h"
#import <PureLayout/PureLayout.h>

@implementation AutoSizeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        
        [_titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) excludingEdge:ALEdgeBottom];
        
        UILabel *noLabel = [UILabel newAutoLayoutView];
        noLabel.font = [UIFont systemFontOfSize:20];
        noLabel.numberOfLines = 0;
        noLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:noLabel];
        _noLabel = noLabel;
        
        [noLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel];
        [noLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
        [noLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_titleLabel];
        [noLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
        
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.titleLabel }]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.titleLabel }]];
        
//        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        self.textLabel.numberOfLines = 0;
//        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.textLabel }]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.textLabel }]];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.frame);
    self.noLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.noLabel.frame);
}

@end
