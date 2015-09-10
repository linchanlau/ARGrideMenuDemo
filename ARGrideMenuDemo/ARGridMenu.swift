//
//  ARGridMenu.swift
//  swiftShop
//
//  Created by 刘淋全 on 15/9/2.
//  Copyright (c) 2015年 刘淋全. All rights reserved.
//九宫格菜单按钮

import UIKit

protocol ARGridMenuDelegate
{
    func selectedWithIndex(index:Int)
}

class ARGridMenu: UIView,UIScrollViewDelegate {
    
    private var cellsSp:CGFloat=15.0
    private var rowC:Int=4
    private var columnC:Int=2
    private var menuSV:UIScrollView?
    private var pageControl:UIPageControl?
    private var pageControlIndicatorTintC:UIColor=UIColor.grayColor()
    private var currentPageControlIndicatorTintC:UIColor=UIColor.blueColor()
    private var titleArray=[String]()//标题数组
    private var imageArray=[String]()//图片数组
    private var Y:CGFloat=0
    private var imageCir:Bool=false
    private var titleC:UIColor=UIColor.blackColor()
    private var titleF:UIFont=UIFont.systemFontOfSize(15)
    private var cellImageViewArray=[UIImageView]()
    private var cellTitleArray=[UILabel]()
    private var cellBtnArray=[UIButton]()
    
    var delegate:ARGridMenuDelegate?
    
    var cellsSpacing:CGFloat?{//每个cell的间隔 默认是15
        get{
            return nil
        }
        
        set{
            cellsSp=newValue!
        }
    }
    
    var rowCount:Int?{//每行的cell数量 默认是4
        get{
            return nil
        }
        
        set{
            rowC=newValue!
        }
    }
    
    var columnCount:Int?{//每列的cell数量 默认是2
        get{
            return nil
        }
        
        set{
            columnC=newValue!
        }
    }
    
    var imageCircle:Bool?{//图片是否为原型 默认是正方形
        get{
            return nil
        }
        
        set{
            imageCir=newValue!
        }
    }
    
    var titleColor:UIColor?{//标题颜色 默认是黑色
        get{
            return nil
        }
        
        set{
            titleC=newValue!
        }
    }
    
    var titleFont:UIFont?{//标题字体大小 默认是15
        get{
            return nil
        }
        set{
            titleF=newValue!
        }
    }
    
    var pageControlIndicatorTintColor:UIColor?{//分页控制器非选中状态下的颜色 默认是灰色
        get{
            return nil
        }
        set{
            pageControlIndicatorTintC=newValue!
        }
    }
    
    var currentPageControlIndicatorTintColor:UIColor?{//分页控制器选中状态下的颜色 默认是蓝色
        get{
            return nil
        }
        set{
            currentPageControlIndicatorTintC=newValue!
        }
    }
    
    convenience init(orginY:CGFloat,titleArr:NSArray,imageArr:NSArray)
    {
        self.init(frame: CGRectZero)
        self.backgroundColor=UIColor.whiteColor()
        self.userInteractionEnabled=true
        Y=orginY
        titleArray=titleArr as! [(String)]
        imageArray=imageArr as! [(String)]
        
        menuSV=UIScrollView()
        menuSV?.showsHorizontalScrollIndicator=false
        menuSV?.showsVerticalScrollIndicator=false
        menuSV?.pagingEnabled=true
        menuSV?.delegate=self
        self.addSubview(menuSV!)
        
        for i in 0..<imageArr.count
        {
            var imageView:UIImageView=UIImageView()
            imageView.image=UIImage(named: imageArr[i] as! String)
            menuSV?.addSubview(imageView)
            cellImageViewArray.append(imageView)
            
            var titleLabel:UILabel=UILabel()
            titleLabel.textAlignment=NSTextAlignment.Center
            titleLabel.text=titleArr[i] as? String
            menuSV?.addSubview(titleLabel)
            cellTitleArray.append(titleLabel)
            
            var btn:UIButton=UIButton()
            btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.tag=i
            menuSV?.addSubview(btn)
            cellBtnArray.append(btn)
            
        }
        
        pageControl=UIPageControl()
        pageControl?.currentPage=0
        pageControl?.userInteractionEnabled=false
        self.addSubview(pageControl!)
        self.bringSubviewToFront(pageControl!)
    }
    
    func btnClick(myBtn:UIButton)
    {
        delegate?.selectedWithIndex(myBtn.tag)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var i:Int=Int(scrollView.contentOffset.x/menuSV!.frame.size.width)
        pageControl?.currentPage=i
    }
    
    override func layoutSubviews() {
        var H:CGFloat=0
        var rowC_f:CGFloat=CGFloat(rowC)
        var columnC_f:CGFloat=CGFloat(columnC)
        var view_w:CGFloat=CGFloat(self.frame.size.width)
        var row_1_f:CGFloat=CGFloat(rowC+1)
        var rowc_columnC_f:CGFloat=CGFloat(rowC*columnC)
        var columnC_1_f:CGFloat=CGFloat(columnC+1)
        
       if imageArray.count>rowC
       {
            if imageArray.count>rowC*columnC
            {
                H=15.0+((UIScreen.mainScreen().bounds.size.width-cellsSp*row_1_f)/rowC_f+25.0)*columnC_f
                
        }else
            {
                var rowN:Int=imageArray.count%rowC==0 ? imageArray.count/rowC : imageArray.count/rowC+1
                H=5.0+((UIScreen.mainScreen().bounds.size.width-cellsSp*row_1_f)/rowC_f+25.0)*CGFloat(rowN)
                
        }
       }else{
            H=5.0+(UIScreen.mainScreen().bounds.size.width-cellsSp*row_1_f)/rowC_f+25.0
        }
        self.frame=CGRectMake(0, Y, UIScreen.mainScreen().bounds.size.width, H)
        
        menuSV?.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        
        var pageCount:Int=imageArray.count%(rowC*columnC)==0 ? Int(imageArray.count/(rowC*columnC)) : Int(imageArray.count/(rowC*columnC))+1
        menuSV?.contentSize = CGSizeMake(CGFloat(menuSV!.frame.size.width)*CGFloat(pageCount), menuSV!.frame.size.height)
        
        
       
        for i in 0..<cellImageViewArray.count
        {//  (CGFloat(i)/rowc_columnC_f)*view_w
            var imageView=cellImageViewArray[i] as UIImageView
            imageView.frame = CGRectMake(cellsSp+((view_w-cellsSp*row_1_f)/rowC_f+cellsSp)*((CGFloat(i)%rowc_columnC_f)%rowC_f)+CGFloat(i/rowC/columnC)*view_w, 5.0+CGFloat((i%(rowC*columnC))/rowC)*((view_w-cellsSp*row_1_f)/rowC_f+25.0), (view_w-cellsSp*row_1_f)/rowC_f, (view_w-cellsSp*row_1_f)/rowC_f)
            
            if imageCir
            {
                imageView.clipsToBounds=true
                imageView.layer.cornerRadius=imageView.frame.size.height/2
                imageView.layer.borderWidth=0
                imageView.layer.masksToBounds=true
            }
            
             var titleLabel=cellTitleArray[i] as UILabel
            titleLabel.textColor=titleC
            titleLabel.font=titleF
             titleLabel.frame=CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height, imageView.frame.size.width, 20)
            
            var btn=cellBtnArray[i] as UIButton
            btn.frame=CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height+20.0)
        }
        
        if pageCount>1
        {
            pageControl?.frame=CGRectMake(0.0, self.frame.size.height-15.0, self.frame.size.width, 15)
            pageControl?.pageIndicatorTintColor=pageControlIndicatorTintC
            pageControl?.currentPageIndicatorTintColor=currentPageControlIndicatorTintC
            pageControl?.numberOfPages=pageCount
        }
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
