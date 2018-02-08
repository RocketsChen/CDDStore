//
//  DCAdressDateBase.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/7.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCAdressDateBase.h"

#import "DCAdressItem.h"
#import <FMDB.h>


@interface DCAdressDateBase() <NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}

@end


static DCAdressDateBase *_DBCtl = nil;

@implementation DCAdressDateBase


+ (instancetype)sharedDataBase
{
    if (_DBCtl == nil) {
        
        _DBCtl = [[DCAdressDateBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

- (id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

- (id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


#pragma mark - 初始化
-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"adress.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    NSString *personSql = @"CREATE TABLE 'adress' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'adress_id' VARCHAR(255),'userName' VARCHAR(255),'userPhone' VARCHAR(255),'chooseAdress' VARCHAR(255),'userAdress' VARCHAR(255),'isDefault' VARCHAR(255))";
    
    [_db executeUpdate:personSql];
    
    [_db close];
    
}



#pragma mark - 新增地址
- (void)addNewAdress:(DCAdressItem *)adress
{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM adress"];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"adress_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"adress_id"] integerValue]) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO adress(adress_id,userName,userPhone,chooseAdress,userAdress,isDefault)VALUES(?,?,?,?,?,?)",maxID,adress.userName,adress.userPhone,adress.chooseAdress,adress.userAdress,adress.isDefault];
    
    
    [_db close];
}

#pragma mark - 删除地址
- (void)deleteAdress:(DCAdressItem *)adress
{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM adress WHERE adress_id = ?",adress.ID];
    
    [_db close];
}

#pragma mark - 更新地址
- (void)updateAdress:(DCAdressItem *)adress
{
    [_db open];
    
    [_db executeUpdate:@"UPDATE 'adress' SET userName = ?  WHERE adress_id = ? ",adress.userName,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET userPhone = ?  WHERE adress_id = ? ",adress.userPhone,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET chooseAdress = ? WHERE adress_id = ? ",adress.chooseAdress,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET userAdress = ? WHERE adress_id = ? ",adress.userAdress,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET isDefault = ?  WHERE adress_id = ? ",adress.isDefault,adress.ID];

    [_db close];
}

#pragma mark - 获取所有数据
- (NSMutableArray *)getAllAdressItem
{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM adress"];
    
    while ([res next]) {
        DCAdressItem *adressItem = [[DCAdressItem alloc] init];
        adressItem.ID = @([[res stringForColumn:@"adress_id"] integerValue]);
        adressItem.userName = [res stringForColumn:@"userName"];
        adressItem.userPhone = [res stringForColumn:@"userPhone"];
        adressItem.chooseAdress = [res stringForColumn:@"chooseAdress"];
        adressItem.userAdress = [res stringForColumn:@"userAdress"];
        adressItem.isDefault = [res stringForColumn:@"isDefault"];
        [dataArray addObject:adressItem];
    }
    
    [_db close];
    
    return dataArray;
}



@end
