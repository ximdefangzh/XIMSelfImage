//
//  ViewController.m
//  self_download_image
//
//  Created by ximdefangzh on 16/8/21.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AppModel.h"
#import "AppCell.h"
#import "NSString+SandPath.h"
#define URLStr @"https://raw.githubusercontent.com/ximdefangzh/XIMSelfImage/master/apps.json"
@interface ViewController ()<UITableViewDataSource>

@end

@implementation ViewController{
    NSOperationQueue *_queue;
    NSArray<AppModel *> *_appList;
    NSMutableDictionary *_imgList;
    NSMutableDictionary *_opList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _queue = [[NSOperationQueue alloc] init];
    _imgList = [NSMutableDictionary dictionary];
    _opList = [NSMutableDictionary dictionary];
    [self loadData];
}
-(void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray<NSDictionary *>  *responseObject) {
        NSMutableArray *arrM = [NSMutableArray array];
       [responseObject enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           AppModel *model = [AppModel appWithDict:obj];
           [arrM addObject:model];
       }];
        _appList = [arrM copy];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _appList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appCell" forIndexPath:indexPath];
    AppModel *model = _appList[indexPath.row];
    cell.model = model;
    
    
    UIImage *image = [_imgList objectForKey:model.icon];
    if(image){
        cell.imageView.image = image;
        NSLog(@"load from memory---%@",model.name);
        return cell;
    }
    
    cell.imageView.image = [UIImage imageNamed:@"user_default"];
    image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSString cachePathByString:model.icon]]];
    if(image){
        cell.imageView.image = image;
        [_imgList setObject:image forKey:model.icon];
        NSLog(@"load from file---%@",model.name);
        return cell;
    }
    
    if([_opList objectForKey:model.icon]){
        NSLog(@"downloading....");
        return cell;
    }
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        if(indexPath.row >9){
            [NSThread sleepForTimeInterval:15.0];
        }
        NSURL *url = [NSURL URLWithString:model.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if(img){
//                cell.imageView.image = img;  这里不能再赋值，因为Cell的复用，当下载完后再去赋值时，这个cell已经不是属于你的了，已经被别人复用了，这时候再去修改的话，修改的就是别人的数据了。
                NSLog(@"load from net---%@",model.name);
                [_imgList setObject:img forKey:model.icon];
                //            [data writeToFile:[NSString cachePathByString:model.icon] atomically:YES];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [_opList removeObjectForKey:model.icon];
                NSLog(@"%@",indexPath);
            }
        }];
    }];
    [_opList setObject:op forKey:model.icon];
    [_queue addOperation:op];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_opList removeAllObjects];
    [_imgList removeAllObjects];
    [_queue cancelAllOperations];
}

@end
