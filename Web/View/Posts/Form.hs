module Web.View.Posts.Form where

import Web.View.Prelude


renderForm :: Post -> Html
renderForm post = formFor post [hsx|
    {(textField #title)}
    {(textareaField #body) {helpText = "You can use Markdown here"}}
    {submitButton}
|]
