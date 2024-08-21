#include "lab4_ag.h"
#include "defs.h"
//#include "spinlock.h"
//#include "sleeplock.h"
//#include "fs.h"
//#include "buf.h"

static int disk_data_read_count = 0;
static int disk_data_write_count = 0;
static int disk_inode_read_count = 0;
static int disk_inode_write_count = 0;
//static int free_blocks = 0;
// extern int free_blocks;

void report_disk_data_read() { disk_data_read_count++; }

void report_disk_inode_read() { disk_inode_read_count++; }

void report_disk_data_write() { disk_data_write_count++; }

void report_disk_inode_write() { disk_inode_write_count++; }

//Lab 4 Change:
int get_free_blocks() {
    return count_free_blocks();
}

// int b, bi, m;
// struct buf* bp;
// int dev = 1;

// bp = 0;
// for (b = 0; b < sb.size; b += BPB) {
//     bp = bread(dev, BBLOCK(b, sb));
//     for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
//         m = 1 << (bi % 8);
//         if ((bp->data[bi / 8] & m) == 0) {  // Is block free?
//             free_blocks++;
//         }
//     }
//     brelse(bp);
// }

int report_stats(struct disk_stat* dstat) {
    // cprintf("\nDisk data reads: %d", disk_data_read_count);
    // cprintf("\nDisk inode reads: %d", disk_inode_read_count);
    // cprintf("\nDisk data writes: %d", disk_data_write_count);
    // cprintf("\nDisk inode writes: %d", disk_inode_write_count);
    // cprintf("\nNumber of free blocks on disk: %d\n", free_blocks);z
    dstat->disk_data_read_count = disk_data_read_count;
    dstat->disk_data_write_count = disk_data_write_count;
    dstat->disk_inode_read_count = disk_inode_read_count;
    dstat->disk_inode_write_count = disk_inode_write_count;
    dstat->free_blocks = get_free_blocks();
    return 0;
}
