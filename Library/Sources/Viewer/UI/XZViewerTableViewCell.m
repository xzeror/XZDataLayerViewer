//  Created by Sergey Sayfulin (Ozon) on 27/12/2017.

#import "XZViewerTableViewCell.h"

@implementation XZViewerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *textLabel = self.textLabel;
        textLabel.backgroundColor = self.contentView.backgroundColor;
        textLabel.numberOfLines = 0;
        textLabel.textColor = [UIColor blackColor];
        textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        UILabel *detailTextLabel = self.detailTextLabel;
        detailTextLabel.backgroundColor = self.contentView.backgroundColor;
        detailTextLabel.numberOfLines = 0;
        detailTextLabel.textAlignment = NSTextAlignmentRight;
        detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        detailTextLabel.textColor = [UIColor grayColor];
        detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Resizing priority
        
        [textLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [textLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        [detailTextLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [detailTextLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        // Layout constraints
        
        [NSLayoutConstraint constraintWithItem:textLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.f
                                      constant:8.f].active = YES;
        [NSLayoutConstraint constraintWithItem:textLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.f
                                      constant:8.f].active = YES;
        [NSLayoutConstraint constraintWithItem:textLabel
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:self.contentView
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.f
                                      constant:-8.f].active = YES;
        
        [NSLayoutConstraint constraintWithItem:detailTextLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:textLabel
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.f
                                      constant:0.f].active = YES;
        [NSLayoutConstraint constraintWithItem:detailTextLabel
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:self.contentView
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.f
                                      constant:-8.f].active = YES;
        [NSLayoutConstraint constraintWithItem:detailTextLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.f
                                      constant:-8.f].active = YES;
        
        [NSLayoutConstraint constraintWithItem:detailTextLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:textLabel
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.f
                                      constant:8.f].active = YES;
        
        NSLayoutConstraint *cellHeightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.f
                                                                                 constant:44.f];
        cellHeightConstraint.priority = UILayoutPriorityDefaultHigh;
        cellHeightConstraint.active = YES;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
}

#pragma mark - Custom getters && setters

- (NSString *)title {
    return self.textLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
}

- (NSString *)subtitle {
    return self.detailTextLabel.text;
}

- (void)setSubtitle:(NSString *)subtitle {
    self.detailTextLabel.text = subtitle;
}

@end
