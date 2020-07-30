# Notes on Database Model and ORM
## General info
- Rails Active Record Basics: https://guides.rubyonrails.org/active_record_basics.html
- Rails Active Record Migrations: https://guides.rubyonrails.org/active_record_migrations.html
- Rails Active Record Associations: https://www.youtube.com/watch?v=5mhuNSkV_vQ
- Rails (5) Data Types: https://michaelsoolee.com/rails-activerecord-data-types/

## Users table vs User session
Via the users table, you can CRUD all info of a user.
As soon as somebody visits the application, that is considered a (browser) session.
Whenever a user is logged in, that information is added to the current session.
The application uses [Devise](https://github.com/heartcombo/devise),
which [exposes some helpers](https://launchschool.com/blog/how-to-use-devise-in-rails-for-authentication).

E.g. `user_signed_in?` can be used in any controller to check if the current session has a user associated with it.

Note that a session is tied to the browser.
I.e. a user can have multiple sessions open
(e.g. logged in on multiple devices, logged in in Safari and Firefox, logged in in normal and incognito mode...).
All these options, although the same user, are considered separate sessions.

Likewise, multiple users can be logged in at the same time.
However, we can rest assured that Devise's `current_user` helper gives us the user that made the request.
