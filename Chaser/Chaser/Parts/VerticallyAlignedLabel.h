//
//  VerticallyAlignedLabel.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/31.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticallyAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
