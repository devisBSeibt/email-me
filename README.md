# EmailMe

Rails engine providing shared email customization functionality between 
apps.

The engine provides 

* UI to list the emails and edit them with a Bootstrap Markdown browser.
* Can use [Liquid Markup](http://www.liquidmarkup.org) in the templates
* DB table and migrations to save the email templates in the db
* Mailer helper which retrieves the email template from the db, replaces fields with Liquid and then sends the plain text and HTML email

This was built specifically to provide shared functionality to two apps I support.  It's minimally
configurable, but opinionated towards what I need.  For example, currently there is no "create a new
email template" functionality, since new emails mean new workflows.

3rd party libraries included:

* https://github.com/vmg/redcarpet
* https://github.com/Shopify/liquid

Bootstrap Markdown Engine:

* https://github.com/codykrieger/ace-rails-ap
* https://github.com/inacho/bootstrap-markdown-editor

## Configuration

The UI displays some help text to let users know what replacement fields are available.  Create
and initializer for the engine and set the replacement_fields config like so:

```ruby
EmailMe.replacement_fields = {
    "{{user_full_name}}" => "User's full name",
    "{{confirmation_link}}" => "Link to confirm the user registration"
}
```

## Views

Views are provided for index and edit.  If you need to customize, just override the views
by putting your version in

```
views/email_me/mail_templates
```

You can also modify the mailer view by overriding what is in

```
views/email_me/db_mail_template_mailer
```

## To Use

Mount in your routes

```
mount EmailMe::Engine => "/emails", as: "emails"
```

Put in a constraint if authentication is needed

## Dependencies/Assumptions

This engine assumes your app is already using SimpleForm and Bootstrap

