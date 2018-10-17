//
//  ViewController.m
//  XZSort
//
//  Created by kkxz on 2018/10/10.
//  Copyright © 2018年 kkxz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)NSInteger sortType;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sortType = 5;
    if(1==self.sortType){
        [self bubbleSort];//冒泡排序
    }
    else if(2==self.sortType){
        [self selectionSort];//选择排序
    }
    else if(3==self.sortType){
        [self insertSort];//直接插入排序
    }
    else if(4==self.sortType){
        [self hillSort];//希尔排序
    }
    else if(5==self.sortType){
        //二分查找,适应于不经常变动且查找频繁的有序列表。示例：升序 有序列表
        NSArray * arr = @[@7,@17,@28,@36,@47,@58,@69];
        NSInteger binaryIn = [self binSearch:arr target:58];
        NSLog(@"升序二分查找结果：%ld",binaryIn);
//        NSArray * larr = @[@69,@58,@47,@36,@28,@17,@7];
//        NSInteger lbinaryIn = [self binarySearch:larr target:17];
//        NSLog(@"降序二分查找结果：%ld",lbinaryIn);
    }
    
}

//冒泡排序
//升序为例临近的数两两比较 小数在前、大数在后
-(void)bubbleSort
{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"17",@"28",@"36",@"15",@"39", nil];
    NSLog(@"排序前%@",arr);
    for(int i = 0;i < arr.count-1;i++){
        for(int j = 0;j < arr.count -1 - i;j++){
            if([arr[j] intValue] > [arr[j+1] intValue]){
                //这里是升序排序   < 是降序排序
                int temp = [arr[j] intValue];
                arr[j] = arr[j+1];
                arr[j+1] = [NSString stringWithFormat:@"%d",temp];
            }
            NSLog(@"排序运行结果 i = %d ,%@",i,arr);
        }
    }
    NSLog(@"排序后输出结果%@",arr);
}

//选择排序
//升序为例 未排序序列中找最小元素 放到起始位置，剩余未排序中继续寻找最小元素，放到已排序序列末尾，直到所有元素均排序完毕。
-(void)selectionSort
{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"17",@"28",@"36",@"15",@"39", nil];
    for(int i=0;i<arr.count-1;i++){
        for(int j=i+1;j<arr.count;j++){
            if([arr[i] intValue] > [arr[j] intValue]){
                int temp = [arr[i] intValue];
                arr[i] = arr[j];
                arr[j] = [NSString stringWithFormat:@"%d",temp];
            }
            NSLog(@"排序运行结果 i = %d j = %d,%@",i,j,arr);
        }
    }
    NSLog(@"排序后输出结果%@",arr);
}

//直接插入排序
//将数据分为两个部分，有序部分和无序部分，一开始有序部分包含第一个元素，依次将无序的元素插到有序部分，直到所有元素有序。
-(void)insertSort
{
    NSMutableArray * list = [NSMutableArray arrayWithObjects:@"15",@"25",@"5",@"95",@"85", nil];
    NSLog(@"未排序前list %@",list);
    for(int i = 1;i<list.count;i++){
        int j = i;
        int temp = [list[i] intValue];
        while (j>0&&(temp < [list[j-1] intValue])) {
            [list replaceObjectAtIndex:j withObject:list[j-1]];
            j--;
        }
        [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:temp]];
        NSLog(@"排序运行结果 i = %d j = %d,%@",i,j,list);
    }
    NSLog(@"排序后的list %@",list);
}

//希尔排序
-(void)hillSort
{
    NSMutableArray * list = [NSMutableArray arrayWithObjects:@"15",@"25",@"5",@"95",@"85", nil];
    NSLog(@"未排序前list %@",list);
    int gap = list.count/2.0;
    while (gap >= 1) {
        for(int i = gap;i<list.count;i++){
            int temp = [list[i] intValue];
            int j = i;
            while (j>=gap && temp < [list[j-gap] intValue]) {
                [list replaceObjectAtIndex:j withObject:list[j-gap]];
                j-=gap;
            }
            [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:temp]];
        }
        gap = gap/2;
    }
   NSLog(@"排序后的list %@",list);
}

//二分查找
//while循环  示例：给你一个数组，再给你个 target，找到 target 在数组中的位置，找不到就返回 - 1。
-(NSInteger)binSearch:(NSArray* )arr target:(NSInteger)target
{
    if(arr.count ==0){
        return -1;
    }
    NSInteger start = 0;
    NSInteger end = arr.count - 1;
    NSInteger mid = 0;
    while(start+1 < end){
        mid = start + (end - start)/2;
        if([arr[mid] integerValue] == target){
            return mid;//相邻就退出
        }
        else if([arr[mid] integerValue] < target){//降序 >
            start = mid;
        }
        else {
            end = mid;
        }
    }
    if([arr[start] integerValue] == target){
        return start;
    }
    if([arr[end] integerValue]==target){
        return end;
    }
    return -1;
}


@synthesize sortType = _sortType;

@end
