# Portrait - Backend Solutions Challenge

This document outlines my process for completing the Backend Solutions Challenge for Portrait.

## Why did you choose to work on certain features?

I first started by reading the product roadmap and analyzed each feature one by one. Then I proceeded to setup the application and test out different areas of the app. Features were then prioritized. Placing emphasis on features that could best demonstrate my knowledge as a Rails software developer.
From this I decided the best feature to work on was the "Customer Model" and "Pricing". Why?

- Although user security is very important, I would highly discourage rolling your own authentication layer by yourself. Even though Rails makes this easy with things like `has_secure_password` and the `authenticate` method, there is too much risk with leaving yourself vulnerable. I would prefer to use a proven community supported gem like `devise` or something similar instead. Although adding and setting up the `devise` gem would bring lots of value to Portrait, it's not a very good demonstration of my capabilities as a software developer.

- The above was a similar reasoning for not doing "Nonblocking" and a few of the other features on the roadmap. For "Nonblocking", I would simply add the `sidekiq` gem to Portrait and change a few lines of code within the `site.rb` model. This will allow the image processing to be done in the background via an ActiveJob.

- Finally, without customers and a cash flow coming in, it's hard to have a successfully and scalable business. Working on the "Customer Model" and "Pricing" feature first would help with thinking about how we want to monetize Portrait. Also, I felt "Customer Model" and "Pricing" features were small enough that I could do a really good job of implementing them within a couple of nights.

Once I knew what I was going to work on, I proceeded to do some high level planning and outlined a few next steps for these features. Much of this time was spent deciding what the user interface and database/models will look like.

Below are some quick notes that summarizes my thought process prior starting work on the features:

#### Customer Model - 4 hours

- Add customer model which has an activated/cancelled boolean (customer has many users and user belong to customer)
- Add CRUD UI for customer model (using existing style in Portrait, which consists of Haml, and no new/edit views)
- Need to augment user form to include select box for belonging to a customer
- Need to prevent users who belong to a cancelled customer from creating additional site captures
- Add model and feature specs

#### Pricing - 4 hours

- Add usage tier/plan model (tier has many customers and customer belong to tier)
- Different tiers? Maybe seed data for three tiers? Low, medium, high which have different amount of requests and price (5$ for 10, 10$ for 100, 20$ for 2000)
- Maybe a CRUD UI for tiers?
- Add ability to choose different tiers from customer form
- Show tiers on customer index table?
- How to handle users going over their usage tier? Prevent them from creating additional site captures => move to next usage tier, or contact sales team (aka future work in - billing module)?
- Roll up all user's sites_count into customer model so we can check usage easier? Need to sum all site_counts...after_save callback on user model probably?
- Add models and feature specs

## Did you run into any roadblocks along the way?

- Getting the app up and running was pretty simple, but I did have a few tiny hiccups at the beginning (which was a result of using an older version of Node.js, etc)
- One of the biggest challenges was getting used to the existing coding style of the application. Some examples: how the application was laid out (no new/edit pages, these were rolled up into index and show pages, respectfully), how form error handling was done, how Rspec was setup, etc
- Another roadblock was that I haven't used HAML in a few years, so it took some time to refresh my memory
- Figuring out how best to architect the database models for these new features took some thought and plenty of reworking to get it to something I am happy with

## How accurate was your estimation of time to implement?

I estimated both features to take about 4 hours each (8 hours total). This was excluding the hour (or maybe more) of time which was used to test different areas of the application and to break down details for the feature requirements.

 - "Customer Model" feature took more time than expected. This was finished in about 5-6 hours. Took longer then expected due to challenges of getting used to codebase and coding style.
 - "Pricing" feature finished on time in just under 4 hours.

In total (setup, requirement planning, features, this readme and pull request) this assignment was finished in 10-12 hours.
