//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var blog_list: [Post] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        
        fetchPosts()
    }


    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let posts = blog.response.posts


                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                    
                    self?.blog_list = posts
                    // Reload the table view to display the data
                    self?.tableView.reloadData()
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blog_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Custom Cell") as? CustomTableViewCell else {
            fatalError("Cell not found")
        }
        let post = blog_list[indexPath.row]
        cell.customLabel.text = post.summary
        // Get the first photo in the post's photos array
        if let photo = post.photos.first {
              let url = photo.originalSize.url
              // Load the photo in the image view via Nuke library
             Nuke.loadImage(with: url, into: cell.customImageView)

        }
        // tableView.rowHeight = UITableView.automaticDimension
        cell.customLabel.numberOfLines = 0
        cell.customLabel.lineBreakMode = .byWordWrapping

        return cell
    }
    
    
}
