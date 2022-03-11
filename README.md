# Sample Rails 6 project with Devise Authentication. #

## Overview ##

Site is published on Heroku https://morning-hamlet-93001.herokuapp.com/users/sign_in

The default admin user for the application is mike.prior@optum.com with password password. This application was created on Ruby 3.0 and Rails 6.1.4.4 To create a Rails App with a specific version use

**rails \_6.1.4.4\_ new appname**


## Models, Controllers and Scaffolds ##

The Itemtest Model was scaffolded. 

**rails generate scaffold Itemtest name:string description:text**

The Review Model and Reviews controller were created manually. The Review model has an association with Itemtest.

**rails generate model Review details:string itemtest:references**

**rails generate controller Reviews index show new edit**

Look at the Movieapp example (Lab5) on Moodle

https://mymoodle.ncirl.ie/course/view.php?id=1172#section-6

## Installing Devise and using its Helpers ##

A User model is needed to register users, and store passwords. the Devise Gem can be used for this. Devise creates the User model for you. Add the devise gem to your Gemfile, and do

**bundle install**

**rails g devise:install**

**rails g devise User**

Edit the 'devise' migration file in ./db, and uncomment any additional fields, you would like in your Model. Then do a db:migrate.

**rails db:migrate**

Create an association between the new User table and the existing Itemtest table

**rails g migration add_user_to_itemtest user:references**

**rails db:migrate**

Adjust the associations in the three Models as shown in each file in this repo.

See in the Itemtest and User controllers how we check if a user is logged in.
By default a user can only edit or delete their own items/books. The current_user is evaluated in the Controllers and Views, to achieve this.

## Managing Admin profiles ##

To differentiate between 'Admin' and non 'Admin' users, add a boolean column called 'admin' to the user model/table. We will be using .admin? in Controllers and Views/Layouts, to manage the 'admin' profile. For example, an Admin user can grant the admin privilige to other users, and delete users and entries in the Models, eg:books. A users Admin account is only used for administrative purposes,  so they will need a 'regular' account to create Reviews.

Note also, that the first Admin account, will not appear in the 'Manage Users' list, so it is not possible to delete this user, or remove their Admin status from the Application.

**rails generate migration add_admin_to_users admin:boolean**

**rails db:migrate**

To grant the first user Admin priviliges, set the :admin boolean to true. First, ensure, that the user, you want to grant admin to, has Registered.

Create a migration called UpdateUsers and go to the ./db directory, and edit the file, and add the lines below

**rails g migration UpdateUsers**

 def change

  @u = User.find_by( email: 'mike.prior@optum.com' )

  @u.update_attribute :admin, true

  end

**rails db:migrate**

## Layouts, Partials, Stylesheets, Navbar ##

The ./Views/layouts/application.html.erb has a cdn Bootstrap5 CSS stylesheet added. The file also renders the _navbar.html.erb in ./Views/shared. You need to create the shared folder and _navbar.html.erb

There is a method .splash in ./assets/stylesheets/itemtests.css which can be called to set the backround. In this project, the backround is shown only at Login and Registration pages. The method references a book.jpg in ./assets/images
The method is called in ./Views/Devise/sessions/new.html.erb and /Views/Devise/Registrations/new.html.erb
The Itemtest View uses a partial called _form.html.erb

## Helpers and Decorators ##

The Itemtest/index View, calls two helper methods, to show information, unique to a user, when they login. It displays the number of Reviews they have created, and their email address. During Registration/Sign Up, a callback is used to call a method (emailchk) in the EmailType class. The class is created in ./lib/emailtype.rb. The method contacts an api discussed in the api section below, to put an entry into the Users , emailtype column, to indicate if it is a 'Free' or 'Business' email account. The 'index_item_count' helper method displays the emailtype, as well as the users email address, and item count.

<p><%= index_item_count %></p>

<p><%= index_show_country_city %></p>

The 'index_show_country_city' method polls an api to get the users location.

To use a decorator, add the draper gem to your Gemfile, and do a 

**bundle install**

To create a template decorator for your main Controller, in this case Itemtest, do

**rails generate decorator Itemtest**

Then in your controller, eg:Itemtest, add .decorate to the methods, you would like to decorate. Edit the ./app/decorators/itemtest_decorator.rb and create a method, see the example. Then call the method (in this case alias) in your View, eg:index. In this example, we remove any characters after @ (and including @) for the users email address.

<td><%= itemtest.alias %></td>

## Working with apis and setting keys as variables ##

We use the email validation and/or Geo ip apis, in our project. https://www.abstractapi.com/
Get a free account for the api service you want to use, and get the key. The email validation code is in ./lib/emailtype.rb. Note how we set the key as a variable. To store env keys, for test/development, create a .env file, in the project root directory, with the contents below, use your own key. The keys below are not valid.

ABSTRACT_EMAIL_API=21259243378d784e1efdeb6645

ABSTRACT_GEO_API=21280f43de9c81ee0ecb697652

Edit your Gemfile and add the dotenv-rails Gem to your Gemfile and

**bundle install**

Note on Heroku, you will need to set the variables, using

  heroku config:set ABSTRACT_EMAIL_API=21259243378d784e1efdeb6645

  heroku config:set ABSTRACT_GEO_API=2123a680f43de9c81ee0ecb697652

The code in ./lib/emailtype.rb for the email api, is similar to the Geoip code in the Itemtest_helper.rb. The code makes a request, and parses the response as a json object, and creates a hash, so you can iterative over the contents, to extract what you need.

## Using your own Gem in your project ##

A Gem called 'checkvalidmx' has been created to query the mx record for an email domain, to see if it is valid. If it is invalid, the Registration process will fail, reporting an error to the user. The method is called as a validation check, in the User model

validate :CheckValidMX

The Gem was copied to a folder CheckValidMX, off the project root folder, and added to the Gemfile

gem 'checkvalidmx', :path => './CheckValidMX/'

## Cookiestore session cookies, active-record-session_store and your own cookies ##

By default, all session data is held in a 'session' cookie. To store the information in the database, add the activerecord-session_store.

gem 'activerecord-session_store'

**rails generate active_record:session_migration**

and the last part is to create a file 'session_store.rb', with the line below,  in ../config/initializers/

Rails.application.config.session_store :active_record_store, :key => '_my_app_session'

Note that when you initially push your project to Heroku, there will be no database, so that file should only be added, after the site is up and running (after a heroku run rails:dbmigrate is done). You could rename it to backup_session_store.rb, when the site is initially published, and then rename the file to remove backup_ and git add,commit/push the change.

**heroku run rails db:migrate**

The Itemtest calls a cookie-bar from a cdn, to set a 'cookiebar cookie to 'CookieAllowed' or 'CookieDisallowed'. This can then be checked in the controller (in this case Itemtest) before setting cookies. Once the user consents, then you can set cookies. The cookie-bar assumes that the Devise session cookie is allowed, and is only asking for consent, to your tracking cookies.

https://cookie-bar.eu/

To create your own cookie, for example, to prevent a user from creating multiple entries, within 5 minutes, see the create method, in the itemtests controller. (note the cookie-bar) cookie check also.




## Working with images and 'active_storage' ##

In Rails 6, the 'image_processing' Gem can be used with 'active_storage' to manage images.

Add these to your Gemfile

gem 'image_processing'

gem 'azure-storage-blob'

**bundle install**

**rails active_storage:install**

**rails db:migrate**

Note for this project I am using azure blob storage. In ./config/environments/production.rb add this line

config.active_storage.service = :azure


make sure this line is removed 'config.active_storage.service = :local

Modify ./config/storage.yml to configure the object storage service you want to use. In Heroku, you cannot use local storage, so will need to use Azure or Aws/S3, for Production. The settings in storage.yml, can be used for your project.

To load an image to a Review/Article, edit the _form/partial as follows.

  <div class="field">
    <%#= form.label :Upload an image %>
  <%= form.file_field :image %>
  </div>

  To view the image in the index or show methods/views, use

  <td><%= image_tag itemtest.image.variant(resize_to_fit: [50, 50]) %></td>

  Note that on the show View, we use a different size. The variant method will save different size images to our storage. Note the Variant method added to the Itemtest model.

## Testing ##

Please create your own tests
