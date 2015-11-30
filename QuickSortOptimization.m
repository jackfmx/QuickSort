//
//  QuickSortOptimization.m
//  QuickSort
//  3数取中
//  优化不必要的交换
//  优化小数组时的排序方案
//  优化递归操作
//  Created by jack on 15/11/30.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "QuickSortOptimization.h"
#define MAX_INSERT_SORT_NUM 7
@implementation QuickSortOptimization

+  (void)quickSortOptimizationWithArray:(NSMutableArray *)array
{
    int leftIndex = 0;
    int rightIndex = (int)array.count - 1;
    [[self alloc] quickSortWithArray:array left:leftIndex right:rightIndex];
}

- (void) quickSortWithArray:(NSMutableArray *)array left:(int)left right:(int)right
{
    if (left >= right)
        return;
    if (right - left + 1 > MAX_INSERT_SORT_NUM) {
        int middleIndex = [self patitionArray:array left:left right:right];
        if (middleIndex - left > right - middleIndex) {
            [self quickSortWithArray:array left:left right:middleIndex - 1];
            left = middleIndex + 1;
        }
        else
        {
            [self quickSortWithArray:array left:middleIndex + 1 right:right];
            right = middleIndex - 1;
        }
    }
    else
    {
        //直接插入排序
        [self insertSortWithArray:array];
    }
    
    
}

- (void) insertSortWithArray:(NSMutableArray *)array{
    for (int i = 1; i < array.count; i++) {
        int temp = [array[i] intValue];
        int j = i - 1;
        while (j > 0 && [array[j] intValue] > temp) {
            array[j + 1] = array[j];
            j--;
        }
        array[j + 1] = [NSNumber numberWithInt:temp];
    }
    
}

- (int) patitionArray:(NSMutableArray *) array left:(int)left right:(int)right
{
    int middle = left + (right -left) / 2;
    //使中间的数不小也不大
    if (array[left] > array[right]) {
        [self swapInArray:array A:left withB:right];
    }
    if (array[middle] > array[right]) {
        [self swapInArray:array A:middle withB:right];
    }
    if (array[middle] > array[left]) {
        [self swapInArray:array A:middle withB:left];
    }
    int pivot = [array[left] intValue];
    while (left < right) {
        while (left < right && [array[right] intValue] >= pivot ) {
            right--;
        }
        array[left] = array[right];
        while (left < right && [array[left] intValue] <= pivot) {
            left++;
        }
        array[right] = array[left];
    }
    array[left] = [NSNumber numberWithInt:pivot];
    return left;
    
}

- (void) swapInArray:(NSMutableArray *)array A:(int)a withB:(int)b
{
    id temp = array[a];
    array[a] = array[b];
    array[b] = temp;
}

@end
