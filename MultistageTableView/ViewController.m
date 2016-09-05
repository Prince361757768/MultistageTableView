//
//  ViewController.m
//  MultistageTableView
//
//  Created by Y杨定甲 on 16/8/12.
//  Copyright © 2016年 damai. All rights reserved.
//

#import "ViewController.h"
#import "PHSearchNotingCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *CategoryTableView;
@end

@implementation ViewController{
    NSIndexPath *selectIndex;//当前选中的下标
    BOOL isOpen;
    
}
-(UITableView *)CategoryTableView
{
    if (_CategoryTableView == nil) {
        _CategoryTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _CategoryTableView.delegate = self;
        _CategoryTableView.dataSource = self;
        _CategoryTableView.showsHorizontalScrollIndicator = NO;
        _CategoryTableView.showsVerticalScrollIndicator = NO;
        _CategoryTableView.separatorColor = [UIColor clearColor];
        _CategoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _CategoryTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.CategoryTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isOpen && selectIndex.section == section) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if (isOpen && selectIndex.section == indexPath.section && indexPath.row != 0) {
        
        static NSString *cellMark = @"PHSearchNotingCell";
        PHSearchNotingCell *searchNothingCell = [tableView dequeueReusableCellWithIdentifier:cellMark];
        if (searchNothingCell == nil) {
            searchNothingCell = [[NSBundle mainBundle] loadNibNamed:@"PHSearchNotingCell" owner:nil options:nil].lastObject;
        }
        return searchNothingCell;
        
    }else{
        //未展开状态
        static NSString *CellIdentifier1 = @"cellidentifer1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.textLabel.text = @"第一层cell";
                cell.backgroundColor = [UIColor greenColor];
                
            });
        });
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isOpen && selectIndex.section == indexPath.section && indexPath.row != 0) {
        //100是cell高度，3是个数
        return 100*3;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        /**
         *  expand cell select method
         */
        //需要扩展
        if ([indexPath isEqual:selectIndex]) {
            //点击当前展开的row收起
            isOpen = NO;
            //第一个参数是展开否     第二个参数代表当前是否有其他行展开
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            selectIndex = nil;
        }else{
            if (!selectIndex) {
                //当前没有展开的情况展开
                selectIndex = indexPath;
//                [self setModel];
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else{
                //有展开的情况下
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else{
        /**
         *  no reaction
         */
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    isOpen = firstDoInsert;
    UITableViewCell *cell = (UITableViewCell *)[self.CategoryTableView cellForRowAtIndexPath:selectIndex];
    
    
//    [Helper startAnimation:cell.triangle Up:firstDoInsert complete:^{
//        
//    }];
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    //因为只有两行
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:selectIndex.section];
    [rowToInsert addObject:indexPathToInsert];
    
    [self.CategoryTableView beginUpdates];
    if (firstDoInsert)
    {
        [self.CategoryTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationLeft];
    }
    else
    {
        [self.CategoryTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationRight];
    }
    
    [self.CategoryTableView endUpdates];
    
    if (nextDoInsert) {
        isOpen = YES;
        selectIndex = [self.CategoryTableView indexPathForSelectedRow];
//        [self setModel];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    if (isOpen){
        [self.CategoryTableView scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
