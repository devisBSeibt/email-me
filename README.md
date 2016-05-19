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

Mount in your routes. Put in a constraint or call authentication method if authentication is needed.

```
mount EmailMe::Engine => "/emails", as: "emails"
```

If using Devise and need authentication for the EmailMe routes, you can do this:

```
authenticate :user, lambda { |u| u.is_admin? } do
  mount EmailMe::Engine => "/emails", as: "emails"
end
```

Require the JS in application.js.coffee

```
#= require email_me/application.js
```

Require the CSS in application.css.sass

```
*= require email_me/application
```

You may need to update some links in your application to reference ```main_app.my_app_path```


Run db:migrate.  Note this engine has a migration that should be run.  It will create the email_me_mail_templates table.

Populate the email_me_mail_templates table.  I used a YAML file which could be loaded up.

**Important**

If you are using HAML in your main application, you must configure HAML to run in "ugly" mode to ensure the textarea and
whitespace get along.  Put a haml.rb file in config/initializers with the following line:

```
```

Update mailers to use the mail templates.  Sample mailer (overriding Devis confirmation mailer:

```
class UserConfirmation < Devise::Mailer

  include ApplicationHelper # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  include EmailMe::DbMailerHelper
  default template_path: 'devise/mailer' # to make sure that you mailer uses the devise views

  default from: "My App<myapp@myapp.com>"

  def confirmation_instructions(record, token, opts={})
    send_template_email(record, token, 'email_template_name_here')
  end

  private

  def send_template_email(user, token, template_name)
    params = {
      'user_name' => user.full_name,
      'user_email' => user.username,
      'confirmation_url' => confirmation_url(user, confirmation_token: token)
    }
    mail_template_email template_name, user.email, params
  end

end
```

## Dependencies/Assumptions

This engine assumes your app is already using SimpleForm and Bootstrap

