#import <UIKit/UIKit.h>
#import "BJBrainyQuotes.h"

@interface NCNotificationNoContentView : UIView
@end


%hook NCNotificationNoContentView

- (id)init {
    if ((self = %orig)) {
        UILabel *label = [self valueForKey:@"_noNotificationsLabel"];
        label.text = @"Loading quote...";
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        
        [BJBrainyQuotes parseQuotesAuthors:^(NSArray *authors, NSArray *quotes) {
            NSUInteger qCount = quotes.count;
            if (qCount == authors.count) {
                u_int32_t hit = arc4random() % qCount;
                dispatch_async(dispatch_get_main_queue(), ^{
                    label.text = [NSString stringWithFormat:@"%@\n- %@", quotes[hit], authors[hit]];
                });
            }
        }];
    }
    
    return self;
}

%end
