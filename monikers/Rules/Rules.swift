//
//  Rules.swift
//  monikers
//
//  Created by Jason Hoang on 4/26/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
/* - Will create screenshots and create labels in Sketch to add here
- create a back button
 

*/

import UIKit 

class Rules: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var slideScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        slideScrollView.delegate = self
        //load the pages
        let slides:[RuleSlide] = createSlides()
        setupSlideScrollView(slides:slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        //put pagecontrol in front of everything else
        view.bringSubview(toFront: pageControl)
        
   
    
    }
    
    func createSlides() -> [RuleSlide]{
        

        
        //create each page
        let slide1:RuleSlide = Bundle.main.loadNibNamed("RuleSlide", owner: self, options: nil)?.first as! RuleSlide
       // slide1.textView.text = "fsdafd"
        slide1.textView.text = """
        1) Select the amount of players when you start a new game then divide everyone up into 2 different teams
        
        2) Choose deck size (the more words, the longer the game)
        
        3) Set the timer (we recommend less time for a large group)
        
        4) Depending on the amount of words and players, everyone will get to add a certain amount of words to the deck.  Some extra words may be added to ensure that everyone enters the same amount of words.
        
        5) Once everyone enters in their words, team 1 will begin.  Team 2 will begin after the timer gets to 0.
        """
        let slide2:RuleSlide = Bundle.main.loadNibNamed("RuleSlide", owner: self, options: nil)?.first as! RuleSlide
        slide2.textView.text = """
        
                        There will be 3 rounds:
        
        Round 1:
        
        Say anything, but the word that is being displayed
        
        Round 2:
        
        One word only.  You can repeat the word as many times as you want, but you can only use one word as a clue for that particular word.
        
        Round 3:
        
        Act it out. No words, only charades.
        
        Team with the most points at the end of the third round wins the game!
        """
        let slide3:RuleSlide = Bundle.main.loadNibNamed("RuleSlide", owner: self, options: nil)?.first as! RuleSlide
        slide3.textView.text = "this is slide 3 MAUHAHAHAHAHAHHAHAH"
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides:[RuleSlide]) {
     
        //frame = what user sees
        slideScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        //contentSize = the whole thing (including hidden from view)
        slideScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        slideScrollView.isPagingEnabled = true
        //add slides to scrollview
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slideScrollView.addSubview(slides[i])
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }


/*3 Rounds:
 
 Setup:
 
 1) Select the amount of players when you start a new game then divide everyone up into 2 different teams
 2) Choose deck size (the more words, the longer the game)
 3) Set the timer (we recommend less time for a large group)
 4) Depending on the amount of words and players, everyone will get to add a certain amount of words to the deck.  Some extra words may be added to ensure that everyone enters the same amount of words.
 5) Once everyone enters in their words, team 1 will begin.  Team 2 will begin after the timer gets to 0.
 
 There will be 3 rounds:
 
 Round 1:
 
 Say anything, but the word that is being displayed
 
 Round 2:
 
 One word only.  You can repeat the word as many times as you want, but you can only use one word as a clue for that particular word.
 
 Round 3:
 
 Act it out. No words, only charades.
 
 Team with the most points at the end of the third round wins the game!
*/



}
