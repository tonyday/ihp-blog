module Web.View.Posts.Show where
import Web.View.Prelude

import qualified Text.MMark as MMark

data ShowView = ShowView { post :: Include "comments" Post }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PostsAction}>Posts</a></li>
                <li class="breadcrumb-item active">Show Post</li>
            </ol>
        </nav>
        <h1>{get #title post}</h1>
        <p>{get #createdAt post |> dateTime}</p>
        <div>{get #body post |> renderMarkdown}</div>

        <a href={NewCommentAction (get #id post) }>Add Comment</a>
        <div>{forEach (get #comments post) renderComment}</div>
    |]

renderMarkdown text =
    case text |> MMark.parse "" of
        Left _error -> "Unable to parse text as Markdown"
        Right markdown -> MMark.render  markdown
                            |> tshow
                            |> preEscapedToHtml

renderComment comment = [hsx|
    <div class="mt-4">
        <h5>{get #author comment}</h5>
        <p>{get #body comment}</p>
        <p class="small text-muted">{get #createdAt comment |> dateTime}</p>
    </div>
|]
