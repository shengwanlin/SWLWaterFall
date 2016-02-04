# SWLWaterFall
=========
[![codecov.io](https://codecov.io/github/ibireme/YYModel/coverage.svg?branch=master)](https://codecov.io/github/ibireme/YYModel?branch=master)

## screen shot

![Benchmark result](https://github.com/shengwanlin/SWLWaterFall/screenShot.png)

## 使用方法

- 将`SWLWaterFallLayout.h`和`SWLWaterFallLayout.m`拷贝到你的工程中。
- 使用`SWLWaterFallLayout`作为collectionView的layout, 设置代理。
- 实现代理方法

---

	
	/// number of columns   设置列数
	- (NSUInteger)numberOfColumnCountWithlayout:(SWLWaterFallLayout *)layout;
	
	/// line spacing        设置间距
	- (CGFloat)lineSpacingWithlayout:(SWLWaterFallLayout *)layout;
	
	/// height of item at indexPath   每个item的高度
	- (CGFloat)SWLWaterFallLayout:(SWLWaterFallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
	
具体内容参照demo.	



