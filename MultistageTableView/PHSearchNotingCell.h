//
//  PHSearchNotingCell.h
//  iMSBuyerTicket
//
//  Created by Y杨定甲 on 16/4/9.
//  Copyright © 2016年 Martin Hartl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockDidSelect)(NSInteger row);

@interface PHSearchNotingCell : UITableViewCell
@property (copy, nonatomic) BlockDidSelect collectionBlock;

//block方法
- (void)handlerCellSelect:(BlockDidSelect)block;

- (void)pushInfoData:(NSMutableArray *)array;
@end
