//
//  TableViewController.m
//  tableViewdetail
//
//  Created by ekhome on 16/11/22.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * row;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1");
    row = [NSMutableArray new];
    for (int i =0; i<100; i++)
    {
        [row addObject:[NSString stringWithFormat:@"我是%ld",(long)i]];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    //    tableViewcell选中无任何效果;
    //    self.tableView.editing = YES;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 64, 50, 50)];
    btn.layer.cornerRadius= 25;
    [btn setTitle:@"E" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor brownColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(ca) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)ca{
    //修改editing属性的值，进入或退出编辑模式
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if(self.tableView.editing){
        
    }
    else{
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return row.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = row[indexPath.row];
    cell.accessoryType      = UITableViewCellAccessoryNone;
    
    
    /**
        添加长按手势
     */
    UILongPressGestureRecognizer * longPressGesture =         [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];
    
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor orangeColor];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    UILabel *lab = [UILabel new];
    [view addSubview:lab];
    lab.text = [NSString stringWithFormat:@"我是%ld",(long)section];
    lab.font = [UIFont systemFontOfSize:18 weight:30];
    lab.textColor = [UIColor blackColor];
    [lab sizeToFit];
    lab.center = view.center;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return UITableViewCellEditingStyleNone;
        
    }else if ([row[indexPath.row] isEqualToString:[NSString stringWithFormat:@"我是%ld",(long)indexPath.row]])
    {
        return UITableViewCellEditingStyleDelete;
        
    }else{
        return UITableViewCellEditingStyleInsert;
    };
}
 // Override to support editing the table view.
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            //    先更改数据元
            [row removeObjectAtIndex:indexPath.row];
            //    在删除数据元对应的行
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case UITableViewCellEditingStyleInsert:
            //    先更改数据元
            [row insertObject:[NSString stringWithFormat:@"我是添加的%ld",(long)indexPath.row] atIndex:indexPath.row];
            //    在删除数据元对应的行
            [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        default:
            break;
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return row[section];
}


-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return row;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取点击行的cell
    UITableViewCell *cell   = [tableView cellForRowAtIndexPath:indexPath];
    
    // 如果cell已经被标记
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        // 取消标记
        cell.accessoryType  = UITableViewCellAccessoryDetailButton;
    }
    
    // 如果cell未标记
    else{
        // 标记cell
        cell.accessoryType  = UITableViewCellAccessoryCheckmark;
    }
    // 取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
     
     [tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
 }

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
    return index;
}


 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }

//设置滑动时显示多个按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        
        //1.更新数据
        [row removeObjectAtIndex:indexPath.row];
        //2.更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        
    }];
    //删除按钮颜色
    deleteAction.backgroundColor = [UIColor cyanColor];
    //添加一个置顶按钮
    UITableViewRowAction *topRowAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        //1.更新数据
        [row exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        //2.更新UI
        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    }];
    
    //置顶按钮颜色
    topRowAction.backgroundColor = [UIColor magentaColor];
    
    
    //--------更多
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"更多");
        
    }];
    //背景特效
    //moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
    
    //----------收藏
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"收藏" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
    }];
    //收藏按钮颜色
    collectRowAction.backgroundColor = [UIColor greenColor];
    
    //将设置好的按钮方到数组中返回
    return @[deleteAction,topRowAction,moreRowAction,collectRowAction];
    // return @[deleteAction,topRowAction,collectRowAction];
}





// 去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


- (void)setFrame:(CGRect)frame{
    CGRect sectionRect = [self.tableView rectForSection:0];
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame)); [self.tableView setFrame:newFrame];
}


/**-----------------------------长按事件----------------------*/
- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
        [cell becomeFirstResponder];
        
        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"自定义" action:@selector(handleCopyCell:)];
        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"自定义测试" action:@selector(handleDeleteCell:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:itCopy, itDelete, itCopy,itCopy,itCopy, nil]];
        [menu setTargetRect:self.view.frame inView:self.view];
        [menu setMenuVisible:YES animated:YES];
        
        
        
    }
}
- (void)handleCopyCell:(id)sender{//复制cell
    NSLog(@"handle copy cell");
}

- (void)handleDeleteCell:(id)sender{//删除cell
    NSLog(@"handle delete cell");
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}
@end
