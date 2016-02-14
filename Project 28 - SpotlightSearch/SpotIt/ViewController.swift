//
//  ViewController.swift
//  SpotIt
//
//  Created by Gabriel Theodoropoulos on 11/11/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblMovies: UITableView!
    var moviesInfo : NSMutableArray!
    var selectedMovieIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMoviesInfo()
        configureTableView()
        navigationItem.title = "Movies"
        setupSearchableContent()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func loadMoviesInfo() {
        
        if let path = NSBundle.mainBundle().pathForResource("MoviesData", ofType: "plist") {
            moviesInfo = NSMutableArray(contentsOfFile: path)
        }
    }
    
    func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()
        
        for i in 0...(moviesInfo.count - 1) {
            
            let movie = moviesInfo[i] as! [String: String]
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            
            //set the title
            searchableItemAttributeSet.title = movie["Title"]!
            
            //set the image
            let imagePathParts = movie["Image"]!.componentsSeparatedByString(".")
            searchableItemAttributeSet.thumbnailURL = NSBundle.mainBundle().URLForResource(imagePathParts[0], withExtension: imagePathParts[1])
            
            // Set the description.
            searchableItemAttributeSet.contentDescription = movie["Description"]!
            
            var keywords = [String]()
            let movieCategories = movie["Category"]!.componentsSeparatedByString(", ")
            for movieCategory in movieCategories {
                keywords.append(movieCategory)
            }
            
            let stars = movie["Stars"]!.componentsSeparatedByString(", ")
            for star in stars {
                keywords.append(star)
            }
            
            searchableItemAttributeSet.keywords = keywords
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.appcoda.SpotIt.\(i)", domainIdentifier: "movies", attributeSet: searchableItemAttributeSet)
            
            searchableItems.append(searchableItem)
            
            CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(searchableItems) { (error) -> Void in
                if error != nil {
                    print(error?.localizedDescription)
                }
            }
        }
        
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        
        if activity.activityType == CSSearchableItemActionType {
            if let userInfo = activity.userInfo {
                let selectedMovie = userInfo[CSSearchableItemActivityIdentifier] as! String
                selectedMovieIndex = Int(selectedMovie.componentsSeparatedByString(".").last!)
                performSegueWithIdentifier("idSegueShowMovieDetails", sender: self)
            }
        }
    }

    
    func configureTableView() {
        
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.tableFooterView = UIView(frame: CGRectZero)
        tblMovies.registerNib(UINib(nibName: "MovieSummaryCell", bundle: nil), forCellReuseIdentifier: "idCellMovieSummary")
    }
    
    
    // MARK:  UITableView Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if moviesInfo != nil {
            return moviesInfo.count
        }
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellMovieSummary", forIndexPath: indexPath) as! MovieSummaryCell
        let currentMovieInfo = moviesInfo[indexPath.row] as! [String: String]
        
        cell.lblTitle.text = currentMovieInfo["Title"]!
        cell.lblDescription.text = currentMovieInfo["Description"]!
        cell.lblRating.text = currentMovieInfo["Rating"]!
        cell.imgMovieImage.image = UIImage(named: currentMovieInfo["Image"]!)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedMovieIndex = indexPath.row
        performSegueWithIdentifier("idSegueShowMovieDetails", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            
            if identifier == "idSegueShowMovieDetails" {
                let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
                movieDetailsViewController.movieInfo = moviesInfo[selectedMovieIndex] as! [String: String]
            }
            
        }
    }
    
}

