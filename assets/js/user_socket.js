// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import { Socket } from "phoenix";

// And connect to the path in "lib/discuss_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", { params: { token: window.userToken } });

socket.connect();

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {});
  channel
    .join()
    .receive("ok", (resp) => {
      console.log(resp);
      renderComments(resp.comments);
    })
    .receive("error", (resp) => {
      console.log("Unable to join", resp);
    });

  channel.on(`comments:${topicId}:new`, renderComment);
  document.querySelector("button").addEventListener("click", () => {
    const comment = document.querySelector("textarea").value;

    channel.push("comment:add", { comment: comment });
  });
};

const renderComments = (comments) => {
  const renderedComments = comments.map((comment) => {
    return commentTemplate(comment);
  });

  document.querySelector(".collection").innerHTML = renderedComments.join("");
};

const renderComment = (comment) => {
  const renderedComment = commentTemplate(comment);

  document.querySelector(".collection").innerHTML += renderedComment;
};

const commentTemplate = (comment) => {
  let email = "Anonymous";

  if (comment.user) {
    email = comment.user.email;
  }
  return `<li class="collection-item">
  ${comment.comment}
  <div class="secondary-content">
  ${comment.user.email}
  </div>
</li>`;
};

window.createSocket = createSocket;
