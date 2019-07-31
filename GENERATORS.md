# Available Generators:

## Setup
#### The setup generator create:
* your database
* all assets to admin template
* setup for rspec
* setup devise
* dependencies to package.json
* kaminari views
* custom login page for device
* admins crud
* admins seed

Run this generator after create a new project
```
rails generate setup
```

After generate this you can run your server `rails server`

To login use this credentials:
* admin@teste.com
* 123456

To run rspec run:
```
bin/rspec
```

## User Model
#### The user model generator create:
* your model with relation with user
* migration with your params
* user scope for your model
* factory to rspec
* add test to user_spec for your model
* scope with search for
* ask if you want generate list of this user with admin panel
    * if yes generate:
        * controller in admin/
        * views in views/admin/your_user_model
        * add a menu link
        * add route

Run this generator any moment when you want create a new user
```
rails generate user_model YOURMODELNAME field:type field:type
```
After this you need run the migration `rails db:migrate`

## Graphql
#### The graphql generator create:
* graphql setup
* public schema to graphql
* create a route to public schema
* generate a mutation_type and query_type on graphql/types/public
* custom redirect page on user login

Run this generator once when you want to setup your graphql api
```
rails generate graphql
```

After this you can start your server `rails server`
and see your public graphiql on `http://localhost:3000/graphiql`

## Private Graphql
#### The private graphql generator create:
* new private schema
* new graphql controller with autentication
* new mutation_type and query_type, with query me
* route to private api

### Run this generator after create your user_model with `rails g user_model YOURMODELNAME`

Run this generator any moment when you want to create a private graphiql api
```
rails generate private_graphql YOURUSERMODELNAME
```
After this you can sign in and click on GO TO GRAPHIQL and run the query me

## Crud
#### The private crud generator create:
* controller in the admin folder
* all scaffold views
* generate the model
* generate the factory to rspec
* add scope search_for to model
* use pagination to index page
* add menu item for your crud

Run this generator any moment when you want to create any crud
```
rails generate crud YOURMODELNAME field:type field:type
```
After this you need run the migration `rails db:migrate`
Start your server, use admins credentials to login and see your crud!!!!