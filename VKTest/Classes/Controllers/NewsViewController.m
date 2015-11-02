//
//  NewsViewController.m
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "NewsViewController.h"
#import "NetworkManager.h"
#import "NewsTableViewCell.h"
#import <SVPullToRefresh.h>
#import "NewsFooterCollectionReusableView.h"
#import "NewsHeaderCollectionReusableView.h"
#import "NewsTextCollectionViewCell.h"
#import "NewsImageCollectionViewCell.h"
#import <UIImageView+AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "News.h"
#import "Note.h"
#import "Users.h"
#import "Photo.h"

static NSString * kNewsTableViewCellIdentifier = @"NewsTableViewCell";
static NSString * kNewsFooterViewIdentifier = @"NewsFooterCollectionReusableView";
static NSString * kNewsHeaderViewIdentifier = @"NewsHeaderCollectionReusableView";
static NSString * kNewsTextCollectionViewIdentifier = @"NewsTextCollectionViewCell";
static NSString * kNewsImageCollectionViewIdentifier = @"NewsImageCollectionViewCell";


static const CGFloat kMaxPostHeight = 200;

@interface NewsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *news;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem * exitButton = [[UIBarButtonItem alloc] initWithTitle:@"Выход" style:UIBarButtonItemStylePlain target:self action:@selector(exitButtonTapped:)];
    self.navigationItem.rightBarButtonItem = exitButton;
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsHeaderViewIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNewsHeaderViewIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsFooterViewIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNewsFooterViewIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsTextCollectionViewIdentifier bundle:nil] forCellWithReuseIdentifier:kNewsTextCollectionViewIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsImageCollectionViewIdentifier bundle:nil] forCellWithReuseIdentifier:kNewsImageCollectionViewIdentifier];

    
    self.news = [[NSMutableArray alloc] init];
    UIRefreshControl * refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    
    __weak typeof(self) weakSelf = self;
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadNews];
    }];

    [self loadNews];
}

- (void)loadNews {
    __weak typeof(self) weakSelf = self;
    NSMutableString *uids = [NSMutableString string];
    [[NetworkManager sharedInstance] getNews:^(NSArray *news) {
        [news enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Note * note = [[Note alloc] initWithProperties:obj];
            [uids appendString:[NSString stringWithFormat:@"%@,", note.fromID]];
            [self.news addObject:note];
        }];
        
        dispatch_queue_t q = dispatch_queue_create("com.foo.samplequeue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(q, ^{
            [[NetworkManager sharedInstance] getUsers:^(NSArray *users) {
                [users enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    Users *usr = [[Users alloc] initWithProperties:obj];
                    for (Note *note in self.news) {
                        if (note.fromID.longLongValue == usr.userID.longLongValue) {
                            note.user = usr;
                        }
                    }
                }];
                
                [weakSelf.collectionView.infiniteScrollingView stopAnimating];
                [self.collectionView reloadData];
            } uids:uids onError:^(NSError *error) {
                //
            }];
        });
        

    } offset:self.news.count onError:^(NSError *error) {
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UITableViewDelegate
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.news.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NewsTableViewCell * cell;
//    
//    if (cell == nil) {
//        cell = [tableView dequeueReusableCellWithIdentifier:kNewsTableViewCellIdentifier];
//    }
//    
//    Note *note = self.news[indexPath.section];
//    [cell configureCell:note];
//    
//    return cell;
//}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    Note * note = self.news[indexPath.section];

    if (indexPath.row == 0) {
        NewsTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsTextCollectionViewIdentifier forIndexPath:indexPath];
        
        cell.title.text = note.text;
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    } else {
        NewsImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsImageCollectionViewIdentifier forIndexPath:indexPath];
        Photo *photo = [[note urlImages] objectAtIndex:indexPath.row-1];
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:photo.photoURL]];
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.news.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Note *note = self.news[section];
    if ([note numberOfAttachImages] > 2) return 3;
    return 1 + [note numberOfAttachImages];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    Note * note = self.news[indexPath.section];
    if (kind == UICollectionElementKindSectionHeader) {
        NewsHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNewsHeaderViewIdentifier forIndexPath:indexPath];
        [headerView configureView:note];

        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        NewsFooterCollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNewsFooterViewIdentifier forIndexPath:indexPath];
        [footerview configureView:note];
        reusableview = footerview;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.frame.size.width, 55);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.frame.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Note *note = self.news[indexPath.section];
    
    if (indexPath.row > 0) {
        if ([note urlImages].count == 1) {
            Photo *photo = [[note urlImages] objectAtIndex:0];
            CGFloat relation = photo.width.floatValue / photo.height.floatValue;
            return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.width / relation);
        } else {
            return CGSizeMake(self.collectionView.frame.size.width / 2, self.collectionView.frame.size.width / 2);
        }
    }
    
    CGRect labelRect = [note.text
                        boundingRectWithSize:CGSizeMake(self.collectionView.frame.size.width - 16, kMaxPostHeight)
                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                        context:nil];
    return CGSizeMake(self.collectionView.frame.size.width, labelRect.size.height + 16);
}

#pragma mark - Actions 

- (void)exitButtonTapped:(id)sender {
    
}

- (void)refreshTable:(UIRefreshControl *)sender {
    self.news = [NSMutableArray array];
    [self loadNews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
