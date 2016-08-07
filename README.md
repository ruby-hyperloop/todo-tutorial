## Chapter 8 - Conclusion

Well we hope you have had as much fun seeing this come together as we had putting it together!

If you skipped the tutorial and just want to see the app in its final state are in the right place.  Clone the repo, do a `git checkout chapter-8-conclusion` and make sure you do a `bundle install` and a `rake db:migrate` before powering up the server.

In summary here is what we did:

1. We used `reactrb-rails-generator` to install all the bits and pieces we needed in the Gemfile, config files, etc.

2. We added a simple `Todo` rails model.  We wanted the model shared with the client so we moved it to the `app/models/public` directory (instead of just `app/models`)

3. We then built 5 react components and put them in the `app/views/components` directory.  Our component structure uses a simple *flux loop* so that our data flows peacefully from the top level component out to the display, and then gets updated external forces interact with the system.

4. In the course of building our components we used `rspec` and some handy test helpers to run each component through its paces.  Like the components and models the specs cooperatively run on the server and the client, and we can use the standard ruby tool chain with gems like `FactoryGirl`.

5. When we had all our components built, we added a rails route, and a simple controller that rendered our top level component.  

6. Finally we enabled `Synchromesh` which can use polling or websockets to keep our data syncronized across clients.

7. Our components used a total of 98 lines of code, we have a 4 line Todo model, and a 5 line controller.  Plus we added 1 route.  That is a total of 109 lines of code, all written in lovely Ruby.

While our Todo app is simple it uses all the key features of `Reactrb` and `Reactive-Record`.  This structure is scalable is is currently used in a medium sized app with 100's of components, and a large complex model structure.

Reactrb extends the capabilities of existing frameworks like Rails, so you can integrate easily into existing apps, and use all the framework's capabilities. And because the persistence model is active-record, you can build new UI components, or even whole new front-ends while running the same backend.

Reactrb also works well on even smaller apps and can be used for doing the rendering on static websites, so you can use it from tiny static pages, to full scale production apps.
