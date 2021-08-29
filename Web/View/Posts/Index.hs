module Web.View.Posts.Index where
import Web.View.Prelude

data IndexView = IndexView { posts :: [Post], pagination :: Pagination }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={PostsAction}>Posts</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewPostAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Post</th>
                        <th colspan="2">Actions</th>
                    </tr>
                </thead>
                <tbody>{forEach posts renderPost}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]


renderPost :: Post -> Html
renderPost post = [hsx|
    <tr>
        <td><a href={ShowPostAction (get #id post)}>{get #title post}</a></td>
        <td><a href={EditPostAction (get #id post)} class="text-muted">Edit</a></td>
        <td><a href={DeletePostAction (get #id post)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
