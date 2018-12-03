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

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@5,@2,@3,@1,@4,nil];
    self.sortType = 8;
    if(1==self.sortType){
        [self bubbleSort:array];//冒泡排序
    }
    else if(2==self.sortType){
        [self selectSort:array];//选择排序
    }
    else if(3==self.sortType){
        [self insertSort:array];//直接插入排序
    }
    else if(4==self.sortType){
        [self quickSort:array low:0 high:(int)array.count-1];//快速排序
    }
    else if(5==self.sortType){
        [self shellSort:array];//希尔排序
    }
    else if(6==self.sortType){
        [self mergeSort:array];//归并排序
    }
    else if(7==self.sortType){
        [self heapSort:array];//堆排序
    }
    else if(8==self.sortType){
        [self radixSort:array];//基数排序
    }
    else if(9==self.sortType){
        
    }
    else if(10==self.sortType){
        //二分查找,适应于不经常变动且查找频繁的有序列表。示例：升序 有序列表
        NSArray * arr = @[@7,@17,@28,@36,@47,@58,@69];
        NSInteger binaryIn = [self binSearch:arr target:58];
        NSLog(@"升序二分查找结果：%ld",binaryIn);
//        NSArray * larr = @[@69,@58,@47,@36,@28,@17,@7];
//        NSInteger lbinaryIn = [self binarySearch:larr target:17];
//        NSLog(@"降序二分查找结果：%ld",lbinaryIn);
    }
    
}

//TODO:冒泡排序
/*
 https://www.jianshu.com/p/6cac77639080
 时间复杂度：O(n^2)
 冒泡排序是一种稳定排序算法。
 冒泡排序在内循环交换
 升序为例临近的数两两比较 小数在前、大数在后
 相邻的两位进行比较
 */
-(void)bubbleSort:(NSMutableArray *)array {
    NSLog(@"冒泡排序-排序前 %@",array);
    for(int i=0;i<array.count-1;i++){
        for(int j=0;j<array.count-1-i;j++){
            if([array[j] intValue] > [array[j+1] intValue]){
                [array exchangeObjectAtIndex:j+1 withObjectAtIndex:j];
                NSLog(@"冒泡排序-过程：%d %@",i,array);
            }
        }
    }
     NSLog(@"冒泡排序-结果：%@",array);
}

//TODO:选择排序
/*
 https://www.jianshu.com/p/c67e7b60aa92
 时间复杂度：O(n^2)
 选择排序是不稳定的排序方法。
 选择排序在外循环交换
 升序为例 未排序序列中找最小元素 放到起始位置，剩余未排序中继续寻找最小元素，放到已排序序列末尾，直到所有元素均排序完毕。
 */
-(void)selectSort:(NSMutableArray*)array {
    NSLog(@"选择排序-排序前 %@",array);
    for(int i=0;i<array.count-1;i++){
        for (int j=i+1; j<array.count; j++) {
            if([array[i] intValue] > [array[j] intValue]){
                [array exchangeObjectAtIndex:j withObjectAtIndex:i];
                 NSLog(@"选择排序-过程：%d %@",i,array);
            }
        }
    }
     NSLog(@"选择排序-结果：%@",array);
}

//TODO:直接插入排序
/*
 时间复杂度 O(n^2)
 是稳定的算法
 将数据分为两个部分，有序部分和无序部分，一开始有序部分包含第一个元素，依次将无序的元素插到有序部分，直到所有元素有序。
 */
-(void)insertSort:(NSMutableArray*)array {
    NSLog(@"插入排序-排序前 %@",array);
    for(int i=1;i<array.count;i++){
        int j = i;
        NSNumber * temp = array[i];
        while (j>0&&([temp intValue]<[array[j-1] intValue])) {
            [array replaceObjectAtIndex:j withObject:array[j-1]];
            j--;
             NSLog(@"插入排序-过程1：%d %@",i,array);
        }
        [array replaceObjectAtIndex:j withObject:temp];
         NSLog(@"插入排序-过程2：%d %@",i,array);
    }
     NSLog(@"插入排序-结果：%@",array);
}

//TODO:快速排序
/*
 时间复杂度：O(nlogn)
 是不稳定算法
 是对冒泡排序的一种改进。通过一趟排序将要排序的数据分割h成独立的两部分，其中一份的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列
 从数列中挑出一个元素，称为 "基准"（pivot）
 */
-(void)quickSort:(NSMutableArray*)array low:(int)low high:(int)high {
    if(array == nil || array.count==0||low>=high){
        return;
    }
    
     NSLog(@"快速排序-排序前 %@",array);
    
    //取中值
    int i = low;
    int j = high;
    int middle = low + (high-low)/2;
    NSNumber * mid = array[middle];
    
    //开始排序，使得left<mid 同时 right>mid
    while (i<=j) {
        while ([array[i] intValue] < [mid intValue]) {
            i++;
        }
        
        while ([array[j] intValue] > [mid intValue]) {
            j--;
        }
        
        if(i<=j){
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
        NSLog(@"快速排序-过程：%d %@",i,array);
    }
    
    if(low<j){
        [self quickSort:array low:low high:j];
    }
    if(high>i){
        [self quickSort:array low:i high:high];
    }
    
    NSLog(@"快速排序-结果：%@",array);
}


//TODO:希尔排序
/*
 https://www.jianshu.com/p/c74dd2954b8e
 时间复杂度：O(nlogn)
 不稳定排序算法
 是插入排序算法的一种更高效的改进版本
 先将这个待排的记录序列分割成为若干子序列分别进行直接插入排序，待整个序列中的记录“基本有序”时，再对全体记录进行一次直接插入排序。
 */
-(void)shellSort:(NSMutableArray*)array {
    //起始间隔值gap设置为总数一半
    int gap = (int)array.count/2;
    //当gap==1时，循环结束
    while (gap>=1) {
        // 把距离为 gap 的元素编为一个组，扫描所有组
        for (int i=gap; i<array.count; i++) {
            int j = i;
            NSNumber * temp = array[i];
            // 对距离为 gap 的元素组进行排序
            while (j>=gap && [temp intValue]<[array[j-gap] intValue]) {
                [array replaceObjectAtIndex:j withObject:array[j-gap]];
                j = j - gap;
            }
            [array replaceObjectAtIndex:j withObject:temp];
            NSLog(@"希尔排序-过程：%d %@",i,array);
        }
        gap = gap/2;
    }
     NSLog(@"希尔排序-结果：%@",array);
}

//TODO:归并排序
/*
 https://www.jianshu.com/p/3380e35bbd5b
 时间复杂度：O(nlogn)
 是稳定的排序算法
 归并排序是建立在归并操作上的一种有效的排序算法，算法主要采用分治法的一个典型的应用。
 归并排序比较占用内存，但却是一种高效且稳定的算法
 */
-(void)mergeSort:(NSMutableArray*)array {
    /**
     归并排序其实要做两件事：
     （1）“分解”——将序列每次折半划分。
     （2）“合并”——将划分后的序列段两两合并后排序。
     */
    //拆分为元素为1的一个个子数组
    NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:1];
    for(NSNumber*num in array){
        NSMutableArray * subArray = [NSMutableArray array];
        [subArray addObject:num];
        [tempArray addObject:subArray];
    }
    
    /**
     分解操作
     每一次归并操作 tempArray的个数为（当数组个数为偶数时tempArray.count/2;当数组个数为奇数时tempArray.count/2+1）;
     当tempArray.count == 1时，归并排序完成
     */
    while (tempArray.count != 1) {
        NSInteger i = 0;
        //当数组个数为偶数时 进行合并操作， 当数组个数为奇数时，最后一位轮空
        while (i<tempArray.count-1) {
            tempArray[i] = [self mergeArrayFirstList:tempArray[i] secondList:tempArray[i+1]];
            [tempArray removeObjectAtIndex:i+1];
            //继续下一循环的合并操作
            i++;
        }
    }
    NSLog(@"归并排序-结果：%@",tempArray);
}

-(NSArray*)mergeArrayFirstList:(NSArray*)array1 secondList:(NSArray*)array2 {
    //合并序列数组
    NSMutableArray * resultArray = [NSMutableArray array];
    
    //firstIndex是第一段序列的下标 secondIndex是第二段序列的下标
    NSInteger firstIndex = 0;
    NSInteger secondIndex = 0;
    
    // 扫描第一段和第二段序列，直到有一个扫描结束
    while (firstIndex<array1.count && secondIndex < array2.count) {
        // 判断第一段和第二段取出的数哪个更小，将其存入合并序列，并继续向下扫描
        if([array1[firstIndex] floatValue] < [array2[secondIndex] floatValue]){
            [resultArray addObject:array1[firstIndex]];
            firstIndex++;
        }else{
            [resultArray addObject:array2[secondIndex]];
            secondIndex++;
        }
    }
    
    // 若第一段序列还没扫描完，将其全部复制到合并序列
    while (firstIndex < array1.count) {
        [resultArray addObject:array1[firstIndex]];
        firstIndex++;
    }
    
    // 若第二段序列还没扫描完，将其全部复制到合并序列
    while (secondIndex < array2.count) {
        [resultArray addObject:array2[secondIndex]];
        secondIndex++;
    }
    
    //返回合并序列数组
    return resultArray.copy;
}

//TODO:堆排序
/*
 https://www.jianshu.com/p/259462254761
 堆排序 Heap Sort  是一种树形选择排序，是对直接选择排序的有效改进。
 时间复杂度：O(nlogn)
 是不稳定的排序算法
 算法思想：
 根据初始数组去构造初始堆（构建一个完全二叉树，保证所有的父结点都比它的孩子结点数值大）。
 每次交换第一个和最后一个元素，输出最后一个元素（最大值），然后把剩下元素重新调整为大根堆。
 当输出完最后一个元素后，这个数组已经是按照从小到大的顺序排列了。
 */
-(void)heapSort:(NSMutableArray*)array {
    /**
     设当前元素在数组中以R[i]表示，那么，
     (1) 它的左孩子结点是：R[2*i+1];
     (2) 它的右孩子结点是：R[2*i+2];
     (3) 它的父结点是：R[(i-1)/2];
     (4) R[i] <= R[2*i+1] 且 R[i] <= R[2*i+2]。
     */
    //最后一个元素的索引
    NSInteger endIndex = array.count -1;
    //首先构建初始堆
    array = [self heapCreate:array];
    //进行n-1次循环，完成排序
    while (endIndex > 0) {
        //最后一个元素和第一个元素进行交换
        NSNumber * temp = array[0];
        array[0] = array[endIndex];
        array[endIndex] = temp;
        //堆调整
        array = [self heap:array withFatherIndex:0 withEndIndex:endIndex];
        //下一次循环
        endIndex = endIndex -1;
    }
    
     NSLog(@"堆排序-结果：%@",array);
}
//循环建立初始堆
-(NSMutableArray*)heapCreate:(NSMutableArray*)array {
    NSInteger i = array.count/2;
    while (i>=0) {
        array = [self heap:array withFatherIndex:i withEndIndex:array.count];
        i = i -1;
    }
    return array;
}

-(NSMutableArray*)heap:(NSMutableArray*)items withFatherIndex:(NSInteger)fatherIndex withEndIndex:(NSInteger)endIndex {
    //开始元素
    NSNumber * temp = items[fatherIndex];
    //先获得左子索引
    NSInteger childIndex = 2*fatherIndex + 1;
    while (childIndex < endIndex) {
        // 如果有右孩子节点，并且右孩子节点的值大于左孩子节点，则选取右孩子节点
        if((childIndex+1 < endIndex) && ([items[childIndex] floatValue]<[items[childIndex+1] floatValue])){
            childIndex++;
        }
        //如果父节点的值已经大于孩子节点的值，则直接结束
        if([temp floatValue] >= [items[childIndex] floatValue]){
            break;
        }
        //把孩子节点的值赋值给父节点
        items[fatherIndex] = items[childIndex];
        fatherIndex = childIndex;
        childIndex = 2*fatherIndex +1;
    }
    items[fatherIndex] = temp;
    return items;
}

//TODO:基数排序
/*
 时间复杂度：O(nlogRB)
 是稳定的排序算法
 基数排序 Radix Sort 是根据关键字中各位的值，通过对排序的N个元素进行若干趟“分配”和“收集”来实现排序
 是按照低位先排序，然后收集；再按照高位排序，然后再收集；依次类推，直到最高位。有时候有些属性是有优先级顺序的，先按低优先级排序，再按高优先级排序。最后的次序就是高优先级高的在前，高优先级相同的低优先级高的在前。基数排序基于分别排序，分别收集，所以是稳定的。
 */
-(void)radixSort:(NSMutableArray*)array {
    //创建空桶
    NSMutableArray * buckt = [self createBucket];
    //待排数组的最大数值
    NSNumber * maxnumber = [self listMaxItem:array];
    //最大数值的数字位数
    NSInteger maxLength = numberLength(maxnumber);
    //按照从低位到高位的顺序执行排序过程
    for(int digit = 1;digit <= maxLength;digit++){
        //入桶
        for(NSNumber * item in array){
            //确定item,归属哪个桶，以digit位数为基数
            NSInteger baseNumber = [self fetchBaseNumber:item digit:digit];
            NSMutableArray * mutArray = buckt[baseNumber];
            //将数据放入空桶上
            [mutArray addObject:item];
        }
        NSInteger index = 0;
        //出桶
        for(int i=0; i < buckt.count;i++){
            NSMutableArray * bucktArray = buckt[i];
            //将桶的数据放回待排数组中
            while (bucktArray.count !=0) {
                NSNumber * number = [bucktArray objectAtIndex:0];
                array[index] = number;
                [bucktArray removeObjectAtIndex:0];
                index++;
            }
        }
    }
    NSLog(@"基数升序排序结果：%@",array);
}

//创建空桶
-(NSMutableArray*)createBucket {
    NSMutableArray * bucket = [NSMutableArray array];
    for(int index = 0;index <10;index++){
        NSMutableArray * array = [NSMutableArray array];
        [bucket addObject:array];
    }
    return bucket;
}

//数据最大值
-(NSNumber*)listMaxItem:(NSArray*)list {
    NSNumber * maxNumber = list[0];
    for(NSNumber * number in list){
        if([maxNumber intValue] < [number intValue]){
            maxNumber = number;
        }
    }
    return maxNumber;
}

//数字的位数
NSInteger numberLength(NSNumber *number) {
    NSString *string = [NSString stringWithFormat:@"%ld", (long)[number integerValue]];
    return string.length;
}

-(NSInteger)fetchBaseNumber:(NSNumber*)number digit:(NSInteger)digit {
    //digit为基数位数
    if(digit>0 && digit <= numberLength(number)){
        NSMutableArray *numbersArray = [NSMutableArray array];
        NSString *string = [NSString stringWithFormat:@"%ld",[number integerValue]];
        for(int index = 0; index < numberLength(number);index++){
            [numbersArray addObject:[string substringWithRange:NSMakeRange(index, 1)]];
        }
        //number的位数 是几位数的
        NSString * str = numbersArray[numbersArray.count - digit];
        return [str integerValue];
    }
    return 0;
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
